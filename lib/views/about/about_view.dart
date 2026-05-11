// lib/views/about/about_view.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/fade_in_widget.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/layout/footer.dart';
import '../../widgets/layout/scroll_scaffold.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollScaffold(
      sections: [
        _AboutHero(),
        _MissionVisionSection(),
        _TechStackSection(),
        _TeamValuesSection(),
        const Footer(),
      ],
    );
  }
}

class _AboutHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 140,
        bottom: 100,
        left: Responsive.value(context, mobile: 24, desktop: 100),
        right: Responsive.value(context, mobile: 24, desktop: 100),
      ),
      decoration: BoxDecoration(
        gradient: dc.heroGradient,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInWidget(
                    uniqueKey: 'about_hero_text', child: _AboutHeroText()),
                const SizedBox(height: 40),
                FadeInWidget(
                    uniqueKey: 'about_hero_visual', child: _AboutHeroVisual()),
              ],
            )
          : Row(
              children: [
                Expanded(
                    flex: 5,
                    child: FadeInWidget(
                        uniqueKey: 'about_hero_text', child: _AboutHeroText())),
                const SizedBox(width: 60),
                Expanded(
                    flex: 4,
                    child: FadeInWidget(
                        uniqueKey: 'about_hero_visual',
                        delay: const Duration(milliseconds: 200),
                        child: _AboutHeroVisual())),
              ],
            ),
    );
  }
}

class _AboutHeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              dc.neonBlue.withOpacity(0.12),
              dc.neonPurple.withOpacity(0.12),
            ]),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: dc.neonBlue.withOpacity(0.3)),
          ),
          child: Text(
            '🤖  ABOUT ROBOGENIUS',
            style: TextStyle(
                color: dc.neonBlue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5),
          ),
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: const Text(
            'Building the\nFuture of Work',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'RoboGenius Tech is a technology company on a mission to eliminate manual work through intelligent automation. Founded with a vision to democratise RPA for businesses of every size, we\'ve delivered over 300 automation solutions across industries.',
          style: TextStyle(color: dc.textSecondary, fontSize: 16, height: 1.7),
        ),
        const SizedBox(height: 32),
        const CustomButton(
          label: 'Our Story',
          icon: Icons.play_circle_outline,
          variant: ButtonVariant.outline,
        ),
      ],
    );
  }
}

class _AboutHeroVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Container(
      height: 320,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            dc.neonBlue.withOpacity(0.08),
            dc.neonPurple.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: dc.neonBlue.withOpacity(0.15)),
      ),
      child: CustomPaint(painter: _TimelinePainter(isDark)),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  final bool isDark;
  const _TimelinePainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final blue = isDark ? AppColors.neonBlue : AppColorsLight.neonBlue;
    final textPrimary =
        isDark ? AppColors.textPrimary : AppColorsLight.textPrimary;
    final textSecondary =
        isDark ? AppColors.textSecondary : AppColorsLight.textSecondary;
    final events = [
      (0.15, '2016', 'Founded'),
      (0.35, '2018', '50+ Projects'),
      (0.55, '2020', 'RPA Focus'),
      (0.75, '2022', 'AI Expansion'),
      (0.90, '2024', '300+ Clients'),
    ];

    // Horizontal line
    final linePaint = Paint()
      ..color = blue.withOpacity(0.3)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(size.width * 0.1, size.height * 0.5),
        Offset(size.width * 0.95, size.height * 0.5), linePaint);

    for (final e in events) {
      final x = size.width * e.$1;
      final y = size.height * 0.5;

      // Dot
      canvas.drawCircle(
          Offset(x, y),
          8,
          Paint()
            ..shader = RadialGradient(
              colors: [blue.withOpacity(0.8), blue],
            ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 8)));
      canvas.drawCircle(
          Offset(x, y),
          12,
          Paint()
            ..color = blue.withOpacity(0.2)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1);

      // Year label (above)
      final yearTp = TextPainter(
        text: TextSpan(
          text: e.$2,
          style: TextStyle(
              color: textPrimary, fontSize: 13, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      yearTp.paint(canvas, Offset(x - yearTp.width / 2, y - 38));

      // Event label (below)
      final eventTp = TextPainter(
        text: TextSpan(
          text: e.$3,
          style: TextStyle(color: textSecondary, fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      eventTp.paint(canvas, Offset(x - eventTp.width / 2, y + 20));
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter old) => old.isDark != isDark;
}

// ─── Mission & Vision ─────────────────────────────────────────────────────────

class _MissionVisionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 100),
        vertical: 100,
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'mv_title',
            child: const SectionTitle(
              badge: '🎯 OUR PURPOSE',
              title: 'Driven by Vision,\nDefined by Impact',
              subtitle:
                  'Every line of code, every bot deployed, every process automated — all in service of one purpose.',
            ),
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(children: [
                  _MvCard(
                    icon: Icons.visibility_outlined,
                    label: 'VISION',
                    title: 'A World Without Manual Work',
                    desc:
                        'We envision a future where every repetitive business process is handled by intelligent automation, freeing humans to focus on creativity, strategy, and innovation.',
                    color: dc.neonBlue,
                    dc: dc,
                  ),
                  const SizedBox(height: 20),
                  _MvCard(
                    icon: Icons.flag_outlined,
                    label: 'MISSION',
                    title: 'Democratise Intelligent Automation',
                    desc:
                        'We make enterprise-grade RPA and AI solutions accessible to businesses of every size — delivering measurable ROI, faster processes, and zero-error execution.',
                    color: dc.neonPurple,
                    dc: dc,
                  ),
                ])
              : Row(
                  children: [
                    Expanded(
                      child: _MvCard(
                        icon: Icons.visibility_outlined,
                        label: 'VISION',
                        title: 'A World Without Manual Work',
                        desc:
                            'We envision a future where every repetitive business process is handled by intelligent automation, freeing humans to focus on creativity, strategy, and innovation.',
                        color: dc.neonBlue,
                        dc: dc,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _MvCard(
                        icon: Icons.flag_outlined,
                        label: 'MISSION',
                        title: 'Democratise Intelligent Automation',
                        desc:
                            'We make enterprise-grade RPA and AI solutions accessible to businesses of every size — delivering measurable ROI, faster processes, and zero-error execution.',
                        color: dc.neonPurple,
                        dc: dc,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _MvCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String title;
  final String desc;
  final Color color;
  final DynamicColors dc;

  const _MvCard({
    required this.icon,
    required this.label,
    required this.title,
    required this.desc,
    required this.color,
    required this.dc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.08),
            dc.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              color: dc.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            desc,
            style: TextStyle(
              color: dc.textSecondary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tech Stack ───────────────────────────────────────────────────────────────

class _TechStackSection extends StatelessWidget {
  static const _techs = [
    ('UiPath', Icons.smart_toy_outlined),
    ('Automation Anywhere', Icons.precision_manufacturing_outlined),
    ('Blue Prism', Icons.hub_outlined),
    ('Flutter', Icons.phone_android_outlined),
    ('Python / AI', Icons.psychology_outlined),
    ('Azure / AWS', Icons.cloud_outlined),
    ('Power Automate', Icons.bolt_outlined),
    ('SAP / Oracle', Icons.storage_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 100),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dc.surface, dc.background],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'tech_title',
            child: const SectionTitle(
              badge: '⚙️ TECHNOLOGY',
              title: 'Expertise Across\nLeading Platforms',
              subtitle:
                  'We are certified partners and practitioners across the world\'s leading RPA and automation platforms.',
            ),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.0,
            ),
            itemCount: _techs.length,
            itemBuilder: (_, i) => FadeInWidget(
              uniqueKey: 'tech_$i',
              delay: Duration(milliseconds: 60 * i),
              child: _TechChip(name: _techs[i].$1, icon: _techs[i].$2),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatefulWidget {
  final String name;
  final IconData icon;
  const _TechChip({required this.name, required this.icon});

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [
                    dc.neonBlue.withOpacity(0.12),
                    dc.neonPurple.withOpacity(0.08),
                  ]
                : [dc.card, dc.surface],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? dc.neonBlue.withOpacity(0.4) : dc.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,
                size: 18, color: _hovered ? dc.neonBlue : dc.textMuted),
            const SizedBox(width: 10),
            Text(
              widget.name,
              style: TextStyle(
                color: _hovered ? dc.textPrimary : dc.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Team Values ──────────────────────────────────────────────────────────────

class _TeamValuesSection extends StatelessWidget {
  static const _values = [
    (
      Icons.lightbulb_outline,
      'Innovation First',
      'We continuously explore emerging automation technologies to stay ahead of the curve.'
    ),
    (
      Icons.handshake_outlined,
      'Client Partnership',
      'We embed ourselves in your business, learning your processes deeply before automating them.'
    ),
    (
      Icons.track_changes_outlined,
      'Results-Driven',
      'Every engagement is measured against hard business KPIs — not just deliverables.'
    ),
    (
      Icons.shield_outlined,
      'Ethical Automation',
      'We build automation that augments human potential, never replaces it without purpose.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 24, desktop: 100),
        vertical: 100,
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'values_title',
            child: const SectionTitle(
              badge: '💎 OUR VALUES',
              title: 'Principles That\nGuide Every Decision',
              subtitle:
                  'Our culture and values shape how we build, deliver, and partner.',
            ),
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 2.5 : 2.8,
            ),
            itemCount: _values.length,
            itemBuilder: (_, i) => FadeInWidget(
              uniqueKey: 'val_$i',
              delay: Duration(milliseconds: 80 * i),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [dc.card, dc.surface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: dc.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          dc.neonBlue.withOpacity(0.15),
                          dc.neonPurple.withOpacity(0.1),
                        ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(_values[i].$1, color: dc.neonBlue, size: 24),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _values[i].$2,
                            style: TextStyle(
                              color: dc.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _values[i].$3,
                            style: TextStyle(
                              color: dc.textSecondary,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
