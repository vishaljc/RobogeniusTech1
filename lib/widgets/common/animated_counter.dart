// lib/widgets/common/animated_counter.dart

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/theme/app_theme.dart';

class AnimatedStatCard extends StatefulWidget {
  final String value;
  final String suffix;
  final String label;
  final IconData icon;
  final int targetValue;
  final String uniqueKey;
  final DynamicColors dc;

  const AnimatedStatCard({
    super.key,
    required this.value,
    required this.suffix,
    required this.label,
    required this.icon,
    required this.targetValue,
    required this.uniqueKey,
    required this.dc,
  });

  @override
  State<AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<AnimatedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _anim = Tween<double>(begin: 0, end: widget.targetValue.toDouble())
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dc = widget.dc;
    return VisibilityDetector(
      key: Key(widget.uniqueKey),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_started) {
          _started = true;
          _ctrl.forward();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [dc.card, dc.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: dc.border),
        ),
        child: Column(children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                dc.neonBlue.withOpacity(0.15),
                dc.neonPurple.withOpacity(0.1),
              ]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(widget.icon, color: dc.neonBlue, size: 24),
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              blendMode: BlendMode.srcIn,
              child: Text(
                '${_anim.value.toInt()}${widget.suffix}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(color: dc.textSecondary, fontSize: 14)),
        ]),
      ),
    );
  }
}
