// lib/widgets/common/fade_in_widget.dart

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideFrom;
  final String? uniqueKey;

  const FadeInWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideFrom = const Offset(0, 40),
    this.uniqueKey,
  });

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _opacity =
        Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(
      begin: widget.slideFrom,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.uniqueKey ?? widget.child.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_triggered) {
          _triggered = true;
          Future.delayed(widget.delay, () {
            if (mounted) _ctrl.forward();
          });
        }
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => Transform.translate(
          offset: _slide.value,
          child: Opacity(opacity: _opacity.value, child: child),
        ),
        child: widget.child,
      ),
    );
  }
}
