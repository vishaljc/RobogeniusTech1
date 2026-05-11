// lib/widgets/common/glass_card.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double blur;
  final Color? borderColor;
  final double borderRadius;
  final bool glowEffect;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.blur = 12,
    this.borderColor,
    this.borderRadius = 16,
    this.glowEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: glowEffect
            ? [
                BoxShadow(
                  color: dc.neonBlue.withOpacity(0.15),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        Color(0x1AFFFFFF),
                        Color(0x08FFFFFF),
                      ]
                    : [
                        Color(0xCCFFFFFF),
                        Color(0xAAFFFFFF),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ??
                    (isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.black.withOpacity(0.08)),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
