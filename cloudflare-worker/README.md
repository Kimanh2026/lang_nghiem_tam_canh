# Tiểu Tịnh Gemini proxy

Cloudflare Worker bảo vệ `GEMINI_API_KEY` khỏi mã Flutter chạy trên trình duyệt.

- Endpoint: `https://lang-nghiem-tieu-tinh.nkimanh932.workers.dev/`
- Secret bắt buộc: `GEMINI_API_KEY`
- Placement: chạy gần `generativelanguage.googleapis.com` để tránh lỗi vùng của Gemini.
- Nguồn web được phép: GitHub Pages hiện tại, tên GitHub Pages dự kiến và localhost kiểm thử.
- Giới hạn mềm: 12 yêu cầu/phút/IP, tối đa 30 tin nhắn và 30.000 ký tự mỗi lượt.

Triển khai bằng Dashboard hoặc Wrangler. Trước khi triển khai bằng Wrangler, chạy
`npx wrangler secret put GEMINI_API_KEY`. Không đưa khóa thật vào tệp trong kho mã.
