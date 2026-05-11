// lib/widgets/layout/footer.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      decoration: BoxDecoration(
        color: dc.surface,
        border: Border(top: BorderSide(color: dc.border, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 80),
        vertical: 60,
      ),
      child: Column(
        children: [
          if (isMobile) ...[
            _FooterBrand(),
            const SizedBox(height: 40),
            _FooterLinks(),
            const SizedBox(height: 40),
            _FooterContact(),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _FooterBrand()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _FooterLinks()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _FooterContact()),
              ],
            ),
          const SizedBox(height: 40),
          Divider(color: dc.border),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '© 2025 RoboGenius Tech. All rights reserved.',
                  style: TextStyle(color: dc.textMuted, fontSize: 13),
                ),
              ),
              Row(
                children: [
                  _SocialIcon(icon: Icons.language),
                  const SizedBox(width: 12),
                  _SocialIcon(icon: Icons.email_outlined),
                  const SizedBox(width: 12),
                  _SocialIcon(icon: Icons.phone_outlined),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.smart_toy_outlined,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              blendMode: BlendMode.srcIn,
              child: const Text(
                'RoboGenius Tech',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Transforming businesses with intelligent robotic automation. We build the future of work — today.',
          style: TextStyle(color: dc.textSecondary, fontSize: 14, height: 1.6),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: dc.neonBlue.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '🤖 Automating the World',
            style: TextStyle(
                color: dc.neonBlue, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final _links = const [
    ('Home', AppConstants.homeRoute),
    ('Services', AppConstants.servicesRoute),
    ('About Us', AppConstants.aboutRoute),
    ('Contact', AppConstants.contactRoute),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: TextStyle(
              color: dc.textPrimary, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 16),
        ..._links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => context.go(link.$2),
              child: Text(
                link.$1,
                style: TextStyle(color: dc.textSecondary, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: TextStyle(
              color: dc.textPrimary, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 16),
        _ContactRow(
            icon: Icons.email_outlined,
            text: AppConstants.contactEmail,
            dc: dc),
        const SizedBox(height: 10),
        _ContactRow(
            icon: Icons.phone_outlined, text: AppConstants.phone, dc: dc),
        const SizedBox(height: 10),
        _ContactRow(
            icon: Icons.location_on_outlined,
            text: AppConstants.address,
            dc: dc),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final DynamicColors dc;
  const _ContactRow({required this.icon, required this.text, required this.dc});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: dc.neonBlue),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style:
                TextStyle(color: dc.textSecondary, fontSize: 13, height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _hovered ? dc.neonBlue.withOpacity(0.15) : Colors.transparent,
          border: Border.all(
            color: _hovered ? dc.neonBlue.withOpacity(0.5) : dc.border,
          ),
        ),
        child: Icon(
          widget.icon,
          color: _hovered ? dc.neonBlue : dc.textMuted,
          size: 18,
        ),
      ),
    );
  }
}
