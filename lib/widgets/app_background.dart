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
      duration: const Duration(seconds: 24),
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
                    math.sin(phase * 0.72) * (isPhone ? 2.5 : 4.5),
                    math.cos(phase * 0.54) * (isPhone ? 3.0 : 4.0),
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
                            child: Image.asset(
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
    final candleCenter = Offset(
      size.width * (isPhone ? 0.50 : 0.72),
      size.height * (isPhone ? 0.62 : 0.68),
    );
    final pulse = 0.5 + 0.5 * math.sin(phase * 5.5);
    final glowRadius = (isPhone ? 72.0 : 105.0) + pulse * 14;
    final glowOpacity = 0.13 + pulse * 0.08;
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color.fromARGB((255 * glowOpacity).round(), 255, 218, 132),
          const Color(0x12FFD787),
          Colors.transparent,
        ],
        stops: const [0, 0.42, 1],
      ).createShader(Rect.fromCircle(center: candleCenter, radius: glowRadius));
    canvas.drawCircle(candleCenter, glowRadius, glowPaint);

    for (var index = 0; index < _sparkles.length; index++) {
      final sparkle = _sparkles[index];
      final sparklePhase = phase * (0.72 + (index % 4) * 0.09) + index * 1.31;
      final twinkle = 0.5 + 0.5 * math.sin(sparklePhase);
      final drift = math.sin(sparklePhase * 0.66) * 7;
      final center = Offset(
        sparkle.dx * size.width,
        sparkle.dy * size.height + drift,
      );
      final radius = 0.8 + twinkle * (index % 3 == 0 ? 2.2 : 1.4);
      final alpha = (22 + twinkle * 86).round();
      final halo = Paint()
        ..color = Color.fromARGB((alpha * 0.32).round(), 255, 239, 198);
      final core = Paint()..color = Color.fromARGB(alpha, 255, 247, 220);
      canvas.drawCircle(center, radius * 2.8, halo);
      canvas.drawCircle(center, radius, core);
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientLightPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isPhone != isPhone;
}
