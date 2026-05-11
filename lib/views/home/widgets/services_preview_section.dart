// lib/views/home/widgets/services_preview_section.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:robogenius/core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../../../viewmodels/services_vm.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/fade_in_widget.dart';
import '../../../widgets/common/section_title.dart';
import '../../../widgets/common/service_card.dart';

class ServicesPreviewSection extends StatelessWidget {
  const ServicesPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    final services = context.watch<ServicesViewModel>().services;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dc.background, dc.surface],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 100),
        vertical: 100,
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'services_title',
            child: const SectionTitle(
              badge: '⚙️ WHAT WE DO',
              title: 'Automation-First\nTechnology Services',
              subtitle:
                  'From intelligent RPA bots to AI-driven applications — we build technology that works for you, not the other way around.',
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
              childAspectRatio: isMobile ? 1.6 : 1.0,
            ),
            itemCount: services.length,
            itemBuilder: (_, i) => FadeInWidget(
              uniqueKey: 'svc_prev_$i',
              delay: Duration(milliseconds: 100 * i),
              child: ServiceCard(service: services[i]),
            ),
          ),
          const SizedBox(height: 48),
          FadeInWidget(
            uniqueKey: 'services_cta',
            child: CustomButton(
              label: 'View All Services',
              onTap: () => context.go(AppConstants.servicesRoute),
              variant: ButtonVariant.outline,
              icon: Icons.arrow_forward,
            ),
          ),
        ],
      ),
    );
  }
}
