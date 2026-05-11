// lib/widgets/layout/responsive_layout.dart

import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) return desktop;
    if (Responsive.isTablet(context)) return tablet ?? desktop;
    return mobile;
  }
}

/// Page scaffold with sticky navbar + footer
class PageScaffold extends StatelessWidget {
  final Widget body;
  final bool showNavbar;
  final bool showFooter;

  const PageScaffold({
    super.key,
    required this.body,
    this.showNavbar = true,
    this.showFooter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      body: body,
    );
  }
}
