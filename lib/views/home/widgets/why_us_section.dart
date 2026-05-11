// lib/views/home/widgets/why_us_section.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/common/fade_in_widget.dart';
import '../../../widgets/common/section_title.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  static const _reasons = [
    (
      Icons.precision_manufacturing_outlined,
      'Enterprise-Grade Automation',
      'We deploy robust RPA bots built for high-volume, mission-critical environments. Our automations are tested, monitored, and continuously optimised.',
    ),
    (
      Icons.bolt_outlined,
      'Rapid Deployment',
      '80% faster go-live than traditional software projects. Our pre-built automation frameworks slash implementation time dramatically.',
    ),
    (
      Icons.schema_outlined,
      'End-to-End Integration',
      'Seamlessly connect ERPs, CRMs, legacy systems, and cloud platforms. No system is off-limits for our automation engineers.',
    ),
    (
      Icons.support_agent_outlined,
      '24/7 Bot Operations',
      'Our robotic workforce never sleeps. Processes run around the clock with real-time monitoring, alerting, and exception handling.',
    ),
    (
      Icons.trending_up_outlined,
      'Measurable ROI',
      'Every automation is mapped to KPIs. Track cost savings, FTE reduction, and error rates on live dashboards from day one.',
    ),
    (
      Icons.security_outlined,
      'Security & Compliance',
      'SOC-2 ready architecture with full audit trails, role-based access, and compliance frameworks built into every automation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 100),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dc.background, dc.surface],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'why_us_title',
            child: const SectionTitle(
              badge: '✅ WHY ROBOGENIUS',
              title: 'Why Industry Leaders\nChoose Us',
              subtitle:
                  'We combine deep automation expertise with cutting-edge technology to deliver solutions that scale with your ambitions.',
            ),
          ),
          const SizedBox(height: 64),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile
                  ? 1
                  : isTablet
                      ? 2
                      : 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 2.2 : 1.3,
            ),
            itemCount: _reasons.length,
            itemBuilder: (_, i) => FadeInWidget(
              uniqueKey: 'why_$i',
              delay: Duration(milliseconds: 80 * i),
              child: _ReasonCard(
                icon: _reasons[i].$1,
                title: _reasons[i].$2,
                desc: _reasons[i].$3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _ReasonCard(
      {required this.icon, required this.title, required this.desc});

  @override
  State<_ReasonCard> createState() => _ReasonCardState();
}

class _ReasonCardState extends State<_ReasonCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [
                    dc.neonBlue.withOpacity(0.1),
                    dc.neonPurple.withOpacity(0.07),
                  ]
                : [dc.card, dc.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? dc.neonBlue.withOpacity(0.35) : dc.border,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: _hovered
                    ? AppColors.buttonGradient
                    : LinearGradient(colors: [
                        dc.neonBlue.withOpacity(0.15),
                        dc.neonPurple.withOpacity(0.1),
                      ]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.icon,
                color: _hovered ? Colors.white : dc.neonBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: dc.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.desc,
                    style: TextStyle(
                      color: dc.textSecondary,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
