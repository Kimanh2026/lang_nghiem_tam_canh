const ALLOWED_ORIGINS = new Set([
  'https://langnghiemtamcanh.pages.dev',
  'https://kimanh2026.github.io',
  'https://langnghiemtamcanh.github.io',
  'http://127.0.0.1:8765',
  'http://localhost:8765',
]);

const rateBuckets = new Map();
const MAX_REQUESTS_PER_MINUTE = 12;
const MAX_MESSAGES = 30;
const MAX_MESSAGE_LENGTH = 4000;
const MAX_TOTAL_LENGTH = 30000;

function corsHeaders(origin) {
  return {
    'Access-Control-Allow-Origin': origin,
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Max-Age': '86400',
    'Cache-Control': 'no-store',
    Vary: 'Origin',
  };
}

function json(origin, status, body) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      ...corsHeaders(origin),
      'Content-Type': 'application/json; charset=utf-8',
    },
  });
}

function isRateLimited(request) {
  const ip = request.headers.get('CF-Connecting-IP') || 'unknown';
  const now = Date.now();
  const recent = (rateBuckets.get(ip) || []).filter((time) => now - time < 60000);
  if (recent.length >= MAX_REQUESTS_PER_MINUTE) return true;
  recent.push(now);
  rateBuckets.set(ip, recent);
  return false;
}

function sanitizeMessages(value) {
  if (!Array.isArray(value) || value.length === 0 || value.length > MAX_MESSAGES) {
    return null;
  }
  let total = 0;
  const messages = [];
  for (const item of value) {
    const role = item?.role === 'model' ? 'model' : item?.role === 'user' ? 'user' : null;
    const text = typeof item?.text === 'string' ? item.text.trim() : '';
    if (!role || !text || text.length > MAX_MESSAGE_LENGTH) return null;
    total += text.length;
    if (total > MAX_TOTAL_LENGTH) return null;
    messages.push({ role, parts: [{ text }] });
  }
  return messages;
}

export default {
  async fetch(request, env) {
    const origin = request.headers.get('Origin') || '';
    const allowedOrigin = ALLOWED_ORIGINS.has(origin) ? origin : '';

    if (request.method === 'GET') {
      return json(allowedOrigin || 'https://kimanh2026.github.io', 200, {
        ok: true,
        service: 'tieu-tinh-gemini-proxy',
      });
    }
    if (!allowedOrigin) return json('null', 403, { error: 'origin_not_allowed' });
    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: corsHeaders(allowedOrigin) });
    }
    if (request.method !== 'POST') return json(allowedOrigin, 405, { error: 'method_not_allowed' });
    if (isRateLimited(request)) return json(allowedOrigin, 429, { error: 'rate_limited' });

    let payload;
    try {
      payload = await request.json();
    } catch {
      return json(allowedOrigin, 400, { error: 'invalid_json' });
    }
    const messages = sanitizeMessages(payload.messages);
    if (!messages) return json(allowedOrigin, 400, { error: 'invalid_messages' });

    const name = typeof payload.userName === 'string'
      ? payload.userName.trim().slice(0, 80)
      : '';
    const address = name ? `Đạo Hữu ${name}` : 'Đạo Hữu';
    const systemInstruction = [
      'Bạn là trợ lý Phật pháp từ bi tên Tiểu Tịnh.',
      'Trả lời bằng tiếng Việt, chính xác, chân thật và mặc định ngắn gọn.',
      'Nếu người dùng yêu cầu chi tiết, câu chuyện hoặc giải thích thì trả lời đầy đủ.',
      'Luôn tự xưng là “con” hoặc “Tiểu Tịnh”, không tự xưng “tôi” hay “mình”.',
      `Mặc định gọi người dùng là “${address}”, trừ khi họ yêu cầu cách xưng hô khác.`,
      'Chỉ mở đầu “A Mi Đà Phật” ở lời chào đầu tiên, không lặp lại trong mọi câu trả lời.',
      'Không bịa đặt điển tích, lời Kinh hoặc lời của các vị Hòa thượng.',
    ].join('\n');

    const googleResponse = await fetch(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': env.GEMINI_API_KEY,
        },
        body: JSON.stringify({
          systemInstruction: { parts: [{ text: systemInstruction }] },
          contents: messages,
          generationConfig: {
            temperature: 0.6,
            maxOutputTokens: 900,
          },
          store: false,
        }),
      },
    );

    if (!googleResponse.ok) {
      const status = googleResponse.status === 429 ? 429 : 502;
      return json(allowedOrigin, status, {
        error: googleResponse.status === 429 ? 'gemini_rate_limited' : 'gemini_unavailable',
      });
    }

    const result = await googleResponse.json();
    const text = result?.candidates?.[0]?.content?.parts
      ?.map((part) => part.text || '')
      .join('')
      .trim();
    if (!text) return json(allowedOrigin, 502, { error: 'empty_response' });
    return json(allowedOrigin, 200, { text });
  },
};
