// lib/views/home/widgets/stats_section.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/common/animated_counter.dart';
import '../../../widgets/common/fade_in_widget.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    final stats = [
      (150, '+', 'Happy Clients', Icons.people_outline),
      (300, '+', 'Projects Delivered', Icons.rocket_launch_outlined),
      (98, '%', 'Automation Success Rate', Icons.verified_outlined),
      (8, '+', 'Years of Excellence', Icons.workspace_premium_outlined),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 100),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [dc.surface, dc.background]
          // Light: start at pure white (matches hero bottom),
          // end at the subtle F7F9FF so the next section has
          // something to contrast against — no gray seam.
              : [const Color(0xFFFFFFFF), const Color(0xFFF7F9FF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'stats_title',
            child: Column(children: [
              ShaderMask(
                shaderCallback: (b) =>
                    AppColors.primaryGradient.createShader(b),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Results That Speak for Themselves',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Trusted by enterprises across industries to automate, innovate, and grow.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: dc.textSecondary, fontSize: 15, height: 1.6),
              ),
            ]),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.0 : 1.1,
            ),
            itemCount: stats.length,
            itemBuilder: (context, i) => FadeInWidget(
              uniqueKey: 'stat_$i',
              delay: Duration(milliseconds: 100 * i),
              child: AnimatedStatCard(
                targetValue: stats[i].$1,
                value: stats[i].$1.toString(),
                suffix: stats[i].$2,
                label: stats[i].$3,
                icon: stats[i].$4,
                uniqueKey: 'stat_counter_$i',
                dc: dc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}