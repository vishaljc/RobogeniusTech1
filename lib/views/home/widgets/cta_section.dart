// lib/views/home/widgets/cta_section.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/fade_in_widget.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 20, desktop: 100),
        vertical: 80,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 28, desktop: 72),
        vertical: 64,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  dc.neonBlue.withOpacity(0.2),
                  dc.neonPurple.withOpacity(0.15),
                  dc.neonCyan.withOpacity(0.2),
                ]
              : [
                  dc.neonBlue.withOpacity(0.15),
                  dc.neonPurple.withOpacity(0.12),
                  dc.surface,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: dc.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? dc.neonBlue.withOpacity(0.3) : dc.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: dc.neonBlue.withOpacity(isDark ? 0.25 : 0.1),
            blurRadius: isDark ? 60 : 30,
            spreadRadius: isDark ? 10 : 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background circuit decoration
          Positioned.fill(
            child: CustomPaint(painter: _CtaPatternPainter(isDark: isDark)),
          ),
          // Content
          FadeInWidget(
            uniqueKey: 'cta_content',
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildText(isMobile, isDark),
                      const SizedBox(height: 32),
                      _buildButtons(context),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildText(isMobile, isDark)),
                      const SizedBox(width: 40),
                      _buildButtons(context),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(bool isMobile, bool isDark) {
    final dc = DynamicColors(isDark);
    // Use theme-appropriate text colors
    final textColor = isDark ? dc.textPrimary : dc.textPrimary;
    final subtextColor = isDark ? dc.textSecondary : dc.textSecondary;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to Automate\nYour Business?',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: textColor,
            fontSize: 34,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Schedule a free automation assessment with our RPA experts and discover how much time and cost you can save.',
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: subtextColor,
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 220,
          child: CustomButton(
            label: 'Get Free Assessment',
            onTap: () => context.go(AppConstants.contactRoute),
            icon: Icons.rocket_launch_outlined,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 220,
          child: CustomButton(
            label: 'View Case Studies',
            onTap: () => context.go(AppConstants.servicesRoute),
            variant: ButtonVariant.ghost,
            icon: Icons.open_in_new,
          ),
        ),
      ],
    );
  }
}

class _CtaPatternPainter extends CustomPainter {
  final bool isDark;

  const _CtaPatternPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // Adjust pattern visibility based on theme
    final lineOpacity = isDark ? 0.06 : 0.03;
    final circleOpacity = isDark ? 0.08 : 0.04;

    // Use theme-appropriate pattern color
    final patternColor = isDark ? Colors.white : Colors.black;

    final paint = Paint()
      ..color = patternColor.withOpacity(lineOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final circlePaint = Paint()
      ..color = patternColor.withOpacity(circleOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(Offset(size.width, 0), 200, circlePaint);
    canvas.drawCircle(Offset(0, size.height), 150, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
