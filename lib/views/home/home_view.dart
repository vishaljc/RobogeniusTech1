// lib/views/home/home_view.dart

import 'package:flutter/material.dart';
import '../../widgets/layout/scroll_scaffold.dart';
import '../../widgets/layout/footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/stats_section.dart';
import 'widgets/services_preview_section.dart';
import 'widgets/why_us_section.dart';
import 'widgets/testimonials_section.dart';
import 'widgets/cta_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScrollScaffold(
      sections: [
        HeroSection(),
        StatsSection(),
        ServicesPreviewSection(),
        WhyUsSection(),
        TestimonialsSection(),
        CtaSection(),
        Footer(),
      ],
    );
  }
}
