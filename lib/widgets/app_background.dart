import 'dart:math' as math;

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                  return ColoredBox(
                    color: const Color(0xFFE7F2F8),
                    child: Transform.translate(
                      offset: offset,
                      child: Transform.scale(
                        key: const Key('ambient-background-transform'),
                        scale: scale,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              isPhone
                                  ? 'assets/images/app-background-mobile-v1.png'
                                  : 'assets/images/app-background-desktop-v1.png',
                              fit: BoxFit.cover,
                              alignment: isPhone
                                  ? Alignment.bottomCenter
                                  : Alignment.centerRight,
                              filterQuality: FilterQuality.high,
                              gaplessPlayback: true,
                            ),
                            CustomPaint(
                              key: const Key('ambient-light-particles'),
                              painter: _AmbientLightPainter(
                                progress: _controller.value,
                                isPhone: isPhone,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
    final candleCenter = _candlePoint(size, isPhone);
    final flicker = 0.5 + 0.5 * math.sin(phase * 5);
    final sway = math.sin(phase * 3) * 2.2 + math.sin(phase * 5) * 0.5;
    final flameBreath = math.sin(phase * 4) * 1.3;
    final glowRadius = (isPhone ? 44.0 : 60.0) + flicker * 11;
    final glowRect = Rect.fromCircle(center: candleCenter, radius: glowRadius);
    canvas.drawCircle(
      candleCenter,
      glowRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color.fromARGB((46 + flicker * 38).round(), 255, 220, 126),
            const Color(0x1CFFD787),
            Colors.transparent,
          ],
          stops: const [0, 0.42, 1],
        ).createShader(glowRect),
    );

    // This is a small translucent inner flame, not a second flame. It shares
    // the exact transform of the background image so it remains on the wick.
    final flameHeight = (isPhone ? 23.0 : 29.0) + flameBreath;
    final flameWidth = isPhone ? 5.5 : 7.0;
    final flameBase = candleCenter + Offset(0, flameHeight * 0.36);
    final flameTip = candleCenter + Offset(sway, -flameHeight * 0.64);
    final flame = Path()
      ..moveTo(flameBase.dx, flameBase.dy)
      ..cubicTo(
        candleCenter.dx - flameWidth,
        candleCenter.dy + flameHeight * 0.05,
        flameTip.dx - flameWidth * 0.42,
        flameTip.dy + flameHeight * 0.26,
        flameTip.dx,
        flameTip.dy,
      )
      ..cubicTo(
        flameTip.dx + flameWidth * 0.52,
        flameTip.dy + flameHeight * 0.28,
        candleCenter.dx + flameWidth,
        candleCenter.dy + flameHeight * 0.05,
        flameBase.dx,
        flameBase.dy,
      )
      ..close();
    canvas.drawPath(
      flame,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xB8FFFFFF), Color(0xC8FFE08A), Color(0xA8FF9A36)],
        ).createShader(flame.getBounds()),
    );

    for (var index = 0; index < _sparkles.length * 3; index++) {
      final sparkle = _sparkles[index % _sparkles.length];
      final sparklePhase = phase * (2 + index % 3) + index * 1.31;
      final twinkle = 0.5 + 0.5 * math.sin(sparklePhase);
      // Full-height travel, with invisible wrap outside the viewport.
      final travel =
          (sparkle.dy + progress + (index ~/ _sparkles.length) * 0.31) % 1;
      final fade = math.min(1.0, math.min(travel, 1 - travel) * 16);
      final center = Offset(
        ((sparkle.dx + (index ~/ _sparkles.length) * 0.23) % 1) * size.width +
            math.sin(phase * 2 + index) * (isPhone ? 12 : 22),
        travel * (size.height + 32) - 16,
      );
      final radius = 1.25 + twinkle * (index % 3 == 0 ? 2.35 : 1.25);
      final alpha = ((112 + twinkle * 138) * fade).round().clamp(0, 255);
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

  Offset _candlePoint(Size viewport, bool phone) {
    final sourceSize = phone ? const Size(946, 2048) : const Size(1673, 941);
    final sourcePoint = phone
        ? const Offset(473, 1188)
        : const Offset(1354, 574);
    final scale = math.max(
      viewport.width / sourceSize.width,
      viewport.height / sourceSize.height,
    );
    final dx = (viewport.width - sourceSize.width * scale) * (phone ? 0.5 : 1);
    final dy =
        (viewport.height - sourceSize.height * scale) * (phone ? 1 : 0.5);
    return Offset(dx + sourcePoint.dx * scale, dy + sourcePoint.dy * scale);
  }
}
