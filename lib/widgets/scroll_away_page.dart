import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

class ScrollAwayPage extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;

  const ScrollAwayPage({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
  });

  @override
  State<ScrollAwayPage> createState() => _ScrollAwayPageState();
}

class _ScrollAwayPageState extends State<ScrollAwayPage> {
  bool _headerVisible = true;

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    final shouldShow = notification.metrics.pixels <= 4;
    final shouldHide = notification.metrics.pixels > 18;
    if (shouldShow && !_headerVisible) {
      setState(() => _headerVisible = true);
    } else if (shouldHide && _headerVisible) {
      setState(() => _headerVisible = false);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: ClipRect(
                child: SizedBox(
                  key: const Key('scroll-away-header'),
                  height: _headerVisible ? 57 : 0,
                  child: AppBar(
                    primary: false,
                    automaticallyImplyLeading: false,
                    title: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    actions: widget.actions,
                    backgroundColor: AppPalette.glassPanel,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(1),
                      child: Container(
                        color: const Color(0x33D4AF37),
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: _onScroll,
                child: widget.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
