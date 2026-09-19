import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPhone = constraints.maxWidth < 600;
        return Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(
              color: const Color(0xFFE7F2F8),
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
            child,
          ],
        );
      },
    );
  }
}
