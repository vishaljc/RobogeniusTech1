// lib/views/home/widgets/testimonials_section.dart

import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/common/fade_in_widget.dart';
import '../../../widgets/common/section_title.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const _testimonials = [
    (
      'RoboGenius automated our entire invoice processing pipeline. We went from 3 days per cycle to 2 hours. The ROI paid for itself in 6 weeks.',
      'Rajesh Mehta',
      'CFO, FinServ India',
      Icons.account_balance_outlined,
    ),
    (
      'Their RPA bots handle 12,000+ transactions daily with zero errors. Our ops team now focuses on strategy instead of data entry.',
      'Priya Sharma',
      'COO, LogiTrack Solutions',
      Icons.local_shipping_outlined,
    ),
    (
      'Exceptional technical expertise. The team understood our complex SAP workflows deeply and delivered automation that exceeded expectations.',
      'Anil Kapoor',
      'CTO, ManufacturePro',
      Icons.precision_manufacturing_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
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
            uniqueKey: 'testimonials_title',
            child: const SectionTitle(
              badge: '💬 CLIENT STORIES',
              title: 'Trusted by Industry\nLeaders Across India',
              subtitle:
                  'Real results from real businesses that chose intelligent automation.',
            ),
          ),
          const SizedBox(height: 60),
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
              childAspectRatio: isMobile ? 1.8 : 1.3,
            ),
            itemCount: _testimonials.length,
            itemBuilder: (_, i) => FadeInWidget(
              uniqueKey: 'testimonial_$i',
              delay: Duration(milliseconds: 120 * i),
              child: _TestimonialCard(data: _testimonials[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatefulWidget {
  final (String, String, String, IconData) data;
  const _TestimonialCard({required this.data});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final (quote, name, role, icon) = widget.data;
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
            color: _hovered ? dc.neonBlue.withOpacity(0.3) : dc.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote icon
            ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              child: const Text(
                '"',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  height: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Stars
            Row(
              children: List.generate(
                5,
                (_) => const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(Icons.star_rounded,
                      color: Color(0xFFFFCC00), size: 16),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Text(
                quote,
                style: TextStyle(
                  color: dc.textSecondary,
                  fontSize: 14,
                  height: 1.65,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        dc.neonBlue.withOpacity(0.2),
                        dc.neonPurple.withOpacity(0.15),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: dc.neonBlue, size: 22),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: dc.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        color: dc.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
