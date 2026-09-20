import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class AppBackground extends StatefulWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  State<AppBackground> createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _reduceMotion = false;
  ImageStream? _imageStream;
  ImageStreamListener? _imageListener;
  ImageInfo? _imageInfo;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 36),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isPhone = MediaQuery.sizeOf(context).width < 600;
    final path = isPhone
        ? 'assets/images/app-background-mobile-v1.png'
        : 'assets/images/app-background-desktop-v1.png';
    if (_imagePath != path) {
      _imagePath = path;
      if (_imageListener != null) _imageStream?.removeListener(_imageListener!);
      _imageStream = AssetImage(
        path,
      ).resolve(createLocalImageConfiguration(context));
      _imageListener = ImageStreamListener((info, _) {
        if (!mounted) {
          info.dispose();
          return;
        }
        setState(() {
          _imageInfo?.dispose();
          _imageInfo = info;
        });
      });
      _imageStream!.addListener(_imageListener!);
    }
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (_reduceMotion == reduceMotion) return;
    _reduceMotion = reduceMotion;
    if (_reduceMotion) {
      _controller.stop();
      _controller.value = 0.28;
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    if (_imageListener != null) _imageStream?.removeListener(_imageListener!);
    _imageInfo?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPhone = constraints.maxWidth < 600;
        return Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final phase = _controller.value * math.pi * 2;
                  final scale = 1.022 + math.sin(phase) * 0.006;
                  final offset = Offset(
                    math.sin(phase) * (isPhone ? 2.5 : 4.5),
                    math.cos(phase) * (isPhone ? 3.0 : 4.0),
                  );
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ColoredBox(
                        color: const Color(0xFFE7F2F8),
                        child: Transform.translate(
                          offset: offset,
                          child: Transform.scale(
                            key: const Key('ambient-background-transform'),
                            scale: scale,
                            child: CustomPaint(
                              painter: _CandlePainter(
                                image: _imageInfo?.image,
                                phase: phase,
                                isPhone: isPhone,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        key: const Key('ambient-light-particles'),
                        painter: _AmbientLightPainter(
                          progress: _controller.value,
                          isPhone: isPhone,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x14FFFFFF),
                    Color(0x0AFFFFFF),
                    Color(0x2411232E),
                  ],
                  stops: [0, 0.58, 1],
                ),
              ),
            ),
            widget.child,
          ],
        );
      },
    );
  }
}

class _AmbientLightPainter extends CustomPainter {
  final double progress;
  final bool isPhone;

  const _AmbientLightPainter({required this.progress, required this.isPhone});

  static const _sparkles = <Offset>[
    Offset(0.08, 0.13),
    Offset(0.19, 0.28),
    Offset(0.32, 0.10),
    Offset(0.45, 0.22),
    Offset(0.58, 0.12),
    Offset(0.72, 0.27),
    Offset(0.87, 0.15),
    Offset(0.93, 0.39),
    Offset(0.13, 0.48),
    Offset(0.29, 0.61),
    Offset(0.42, 0.42),
    Offset(0.63, 0.51),
    Offset(0.78, 0.59),
    Offset(0.91, 0.70),
    Offset(0.17, 0.79),
    Offset(0.38, 0.86),
    Offset(0.59, 0.76),
    Offset(0.82, 0.88),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final phase = progress * math.pi * 2;
    for (var index = 0; index < _sparkles.length * 2; index++) {
      final sparkle = _sparkles[index % _sparkles.length];
      final sparklePhase = phase * (2 + index % 3) + index * 1.31;
      final twinkle = 0.5 + 0.5 * math.sin(sparklePhase);
      // Full-height travel, with invisible wrap outside the viewport.
      final travel =
          (sparkle.dy + progress + (index ~/ _sparkles.length) * 0.47) % 1;
      final fade = math.min(1.0, math.min(travel, 1 - travel) * 16);
      final center = Offset(
        ((sparkle.dx + (index ~/ _sparkles.length) * 0.31) % 1) * size.width +
            math.sin(phase * 2 + index) * (isPhone ? 12 : 22),
        travel * (size.height + 32) - 16,
      );
      final radius = 1.1 + twinkle * (index % 3 == 0 ? 2.0 : 1.0);
      final alpha = ((85 + twinkle * 145) * fade).round();
      final halo = Paint()
        ..color = Color.fromARGB((alpha * 0.32).round(), 255, 239, 198);
      final core = Paint()..color = Color.fromARGB(alpha, 255, 247, 220);
      canvas.drawCircle(center, radius * 2.8, halo);
      canvas.drawCircle(center, radius, core);
      if (index % 6 == 0) {
        final ray = Paint()
          ..color = Color.fromARGB(
            (alpha * twinkle * 0.7).round(),
            255,
            242,
            204,
          )
          ..strokeWidth = 0.7;
        final length = radius * (1.5 + twinkle);
        canvas.drawLine(
          center - Offset(length, 0),
          center + Offset(length, 0),
          ray,
        );
        canvas.drawLine(
          center - Offset(0, length),
          center + Offset(0, length),
          ray,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientLightPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isPhone != isPhone;
}

/// Warps only the photographed flame, keeping its wick and the crystal still.
/// Image-space coordinates follow the same cover fit at every viewport size.
class _CandlePainter extends CustomPainter {
  final ui.Image? image;
  final double phase;
  final bool isPhone;
  const _CandlePainter({
    required this.image,
    required this.phase,
    required this.isPhone,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final source = image;
    if (source == null) return;
    final w = source.width.toDouble();
    final h = source.height.toDouble();
    final cover = math.max(size.width / w, size.height / h);
    final dx = (size.width - w * cover) * (isPhone ? 0.5 : 1.0);
    final dy = (size.height - h * cover) * (isPhone ? 1.0 : 0.5);
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.translate(dx, dy);
    canvas.scale(cover);
    canvas.drawImage(
      source,
      Offset.zero,
      Paint()..filterQuality = FilterQuality.medium,
    );
    final region = isPhone
        ? Rect.fromLTRB(w * 0.463, h * 0.650, w * 0.537, h * 0.737)
        : Rect.fromLTRB(w * 0.786, h * 0.528, w * 0.835, h * 0.649);
    const columns = 16;
    const rows = 24;
    final positions = <Offset>[];
    final textures = <Offset>[];
    final indices = <int>[];
    final sway = math.sin(phase * 12) * 0.70 + math.sin(phase * 19) * 0.30;
    for (var y = 0; y <= rows; y++) {
      for (var x = 0; x <= columns; x++) {
        final u = x / columns;
        final v = y / rows;
        final original = Offset(
          region.left + region.width * u,
          region.top + region.height * v,
        );
        // Zero displacement at every edge prevents seams and keeps the wick anchored.
        final envelope =
            math.pow(math.sin(math.pi * u), 2) * math.sin(math.pi * v);
        positions.add(
          original +
              Offset(
                sway * region.width * 0.10 * envelope * (1 - v),
                math.sin(phase * 17) * region.height * 0.015 * envelope,
              ),
        );
        textures.add(original);
        if (x < columns && y < rows) {
          final a = y * (columns + 1) + x;
          final b = a + columns + 1;
          indices.addAll([a, a + 1, b, a + 1, b + 1, b]);
        }
      }
    }
    final mesh = ui.Vertices(
      ui.VertexMode.triangles,
      positions,
      textureCoordinates: textures,
      indices: indices,
    );
    final shader = ui.ImageShader(
      source,
      TileMode.clamp,
      TileMode.clamp,
      Matrix4.identity().storage,
      filterQuality: FilterQuality.medium,
    );
    canvas.drawVertices(mesh, BlendMode.srcOver, Paint()..shader = shader);
    mesh.dispose();
    shader.dispose();
    final center = Offset(region.center.dx, region.top + region.height * 0.58);
    final glow = Rect.fromCircle(center: center, radius: region.height * 0.65);
    canvas.drawOval(
      glow,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color.fromARGB(
              (18 + 12 * (0.5 + 0.5 * math.sin(phase * 17))).round(),
              255,
              210,
              112,
            ),
            Colors.transparent,
          ],
        ).createShader(glow),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CandlePainter oldDelegate) =>
      oldDelegate.image != image ||
      oldDelegate.phase != phase ||
      oldDelegate.isPhone != isPhone;
}
