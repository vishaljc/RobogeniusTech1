// lib/widgets/common/section_title.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String badge;
  final String title;
  final String subtitle;
  final TextAlign textAlign;

  const SectionTitle({
    super.key,
    required this.badge,
    required this.title,
    required this.subtitle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    final isCenter = textAlign == TextAlign.center;
    final isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                dc.neonBlue.withOpacity(0.15),
                dc.neonPurple.withOpacity(0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: dc.neonBlue.withOpacity(0.3), width: 1),
          ),
          child: Text(
            badge,
            style: TextStyle(
              color: dc.neonBlue,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.2,
                fontSize: isMobile ? 26 : 38,
              ),
        ),
        const SizedBox(height: 16),
        // Subtitle
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: isCenter ? 600 : double.infinity),
          child: Text(
            subtitle,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.7,
                  fontSize: isMobile ? 14 : 16,
                ),
          ),
        ),
      ],
    );
  }
}
