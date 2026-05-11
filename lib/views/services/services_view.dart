// lib/views/services/services_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/service_model.dart';
import '../../viewmodels/services_vm.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/fade_in_widget.dart';
import '../../widgets/common/section_title.dart';
import '../../widgets/layout/footer.dart';
import '../../widgets/layout/scroll_scaffold.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollScaffold(
      sections: [
        _ServicesHero(),
        _RpaHighlight(),
        _AllServicesGrid(),
        _ProcessSection(),
        const Footer(),
      ],
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────────

class _ServicesHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'svc_hero',
            child: const SectionTitle(
              badge: '⚙️ OUR SERVICES',
              title: 'Complete Digital\nTransformation Suite',
              subtitle:
                  'From robotic process automation to full-stack development — we provide end-to-end technology services that digitise, automate, and accelerate your business.',
            ),
          ),
        ],
      ),
    );
  }
}

// ─── RPA Highlight ───────────────────────────────────────────────────────────

class _RpaHighlight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    final rpa = context.watch<ServicesViewModel>().highlightService;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 20, desktop: 100),
      ),
      padding: EdgeInsets.all(isMobile ? 28 : 56),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Color(0xFF001A4D), Color(0xFF0A051A)]
              : [Color(0xFFEEF4FF), Color(0xFFF0EAFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: dc.neonBlue.withOpacity(isDark ? 0.3 : 0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: dc.neonBlue.withOpacity(isDark ? 0.1 : 0.08),
            blurRadius: 50,
            spreadRadius: 5,
          ),
        ],
      ),
      child: isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _RpaContent(rpa: rpa),
              const SizedBox(height: 40),
              _RpaVisual(),
            ])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _RpaContent(rpa: rpa)),
                const SizedBox(width: 60),
                Expanded(flex: 4, child: _RpaVisual()),
              ],
            ),
    );
  }
}

class _RpaContent extends StatelessWidget {
  final ServiceModel rpa;
  const _RpaContent({required this.rpa});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return FadeInWidget(
      uniqueKey: 'rpa_content',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: dc.neonBlue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: dc.neonBlue.withOpacity(0.3)),
            ),
            child: Text(
              '🌟  FEATURED SERVICE',
              style: TextStyle(
                  color: dc.neonBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          ShaderMask(
            shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
            blendMode: BlendMode.srcIn,
            child: Text(
              rpa.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            rpa.fullDescription,
            style: TextStyle(
              color: isDark ? dc.textSecondary : dc.textPrimary,
              fontSize: 15,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: rpa.benefits.map((b) => _BenefitChip(label: b)).toList(),
          ),
          const SizedBox(height: 32),
          CustomButton(
              label: 'Explore RPA Solutions', icon: Icons.arrow_forward),
        ],
      ),
    );
  }
}

class _BenefitChip extends StatelessWidget {
  final String label;
  const _BenefitChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: dc.neonBlue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: dc.neonBlue.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dc.neonCyan,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: dc.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _RpaVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return FadeInWidget(
      uniqueKey: 'rpa_visual',
      delay: const Duration(milliseconds: 200),
      child: Container(
        height: 360,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    dc.neonBlue.withOpacity(0.08),
                    dc.neonPurple.withOpacity(0.05),
                  ]
                : [
                    dc.surface,
                    dc.surfaceLight,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: dc.neonBlue.withOpacity(isDark ? 0.15 : 0.2)),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: CustomPaint(painter: _AutomationFlowPainter(isDark)),
      ),
    );
  }
}

class _AutomationFlowPainter extends CustomPainter {
  final bool isDark;
  const _AutomationFlowPainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final blue = isDark ? AppColors.neonBlue : AppColorsLight.neonBlue;
    final purple = isDark ? AppColors.neonPurple : AppColorsLight.neonPurple;
    final surfaceLight =
        isDark ? AppColors.surfaceLight : AppColorsLight.surfaceLight;
    final textSecondary =
        isDark ? AppColors.textSecondary : AppColorsLight.textSecondary;

    final nodePaint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = blue.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final textStyle = TextStyle(
      color: textSecondary,
      fontSize: 11,
    );

    // Nodes
    final nodes = [
      (cx, cy - 120, '🔄', 'Trigger'),
      (cx + 130, cy - 40, '🤖', 'Bot'),
      (cx + 130, cy + 60, '⚡', 'Process'),
      (cx, cy + 120, '✅', 'Output'),
      (cx - 130, cy + 60, '📊', 'Analytics'),
      (cx - 130, cy - 40, '🛡️', 'Monitor'),
    ];

    // Lines
    for (int i = 0; i < nodes.length; i++) {
      final next = nodes[(i + 1) % nodes.length];
      canvas.drawLine(Offset(nodes[i].$1, nodes[i].$2),
          Offset(next.$1, next.$2), linePaint);
    }
    // Center to all
    for (final node in nodes) {
      canvas.drawLine(Offset(cx, cy), Offset(node.$1, node.$2),
          linePaint..color = purple.withOpacity(0.15));
    }

    // Center hub
    nodePaint.shader = RadialGradient(
      colors: [blue, purple],
    ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 36));
    canvas.drawCircle(Offset(cx, cy), 36, nodePaint);
    canvas.drawCircle(
        Offset(cx, cy),
        36,
        Paint()
          ..color = blue.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);

    // Node circles
    for (final node in nodes) {
      final nPaint = Paint()
        ..color = surfaceLight
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(node.$1, node.$2), 28, nPaint);
      canvas.drawCircle(
          Offset(node.$1, node.$2),
          28,
          Paint()
            ..color = blue.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1);

      // Label
      final tp = TextPainter(
        text: TextSpan(text: node.$4, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(node.$1 - tp.width / 2, node.$2 + 34));
    }

    // Center text
    final centerTextColor = isDark ? Colors.white : Colors.white;
    final centerTp = TextPainter(
      text: TextSpan(
        text: 'RPA\nCore',
        style: TextStyle(
            color: centerTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 1.4),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 60);
    centerTp.paint(
        canvas, Offset(cx - centerTp.width / 2, cy - centerTp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _AutomationFlowPainter old) =>
      old.isDark != isDark;
}

// ─── All Services Grid ────────────────────────────────────────────────────────

class _AllServicesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final services = context.watch<ServicesViewModel>().services;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 20, desktop: 100),
        vertical: 80,
      ),
      decoration: BoxDecoration(
        color: isDark ? dc.background : dc.surfaceLight,
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'all_svc_title',
            child: const SectionTitle(
              badge: '🛠 ALL SERVICES',
              title: 'Everything You Need\nto Digitise & Automate',
              subtitle:
                  'A comprehensive portfolio of technology services designed for the digital-first enterprise.',
            ),
          ),
          const SizedBox(height: 60),
          ...services.asMap().entries.map(
                (e) => FadeInWidget(
                  uniqueKey: 'full_svc_${e.key}',
                  delay: Duration(milliseconds: 100 * e.key),
                  child: _FullServiceRow(
                    service: e.value,
                    reversed: e.key.isOdd && !isMobile,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _FullServiceRow extends StatefulWidget {
  final ServiceModel service;
  final bool reversed;
  const _FullServiceRow({required this.service, this.reversed = false});

  @override
  State<_FullServiceRow> createState() => _FullServiceRowState();
}

class _FullServiceRowState extends State<_FullServiceRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    final content = _ServiceDetails(service: widget.service, dc: dc);
    final visual =
        _ServiceIconBox(service: widget.service, hovered: _hovered, dc: dc);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [
                    dc.neonBlue.withOpacity(0.08),
                    dc.neonPurple.withOpacity(0.05),
                  ]
                : isDark
                    ? [dc.card, dc.surface]
                    : [dc.surface, dc.surfaceLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? dc.neonBlue.withOpacity(0.3)
                : isDark
                    ? dc.border
                    : dc.border,
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                visual,
                const SizedBox(height: 20),
                content,
              ])
            : Row(
                children: widget.reversed
                    ? [
                        Expanded(flex: 3, child: content),
                        const SizedBox(width: 40),
                        visual,
                      ]
                    : [
                        visual,
                        const SizedBox(width: 40),
                        Expanded(flex: 3, child: content),
                      ],
              ),
      ),
    );
  }
}

class _ServiceIconBox extends StatelessWidget {
  final ServiceModel service;
  final bool hovered;
  final DynamicColors dc;
  const _ServiceIconBox(
      {required this.service, required this.hovered, required this.dc});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: hovered
            ? AppColors.buttonGradient
            : LinearGradient(
                colors: [
                  dc.neonBlue.withOpacity(0.15),
                  dc.neonPurple.withOpacity(0.1),
                ],
              ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: hovered
            ? [
                BoxShadow(
                  color: dc.neonBlue.withOpacity(0.3),
                  blurRadius: 24,
                )
              ]
            : [],
      ),
      child: Icon(
        service.icon,
        color: hovered ? Colors.white : dc.neonBlue,
        size: 46,
      ),
    );
  }
}

class _ServiceDetails extends StatelessWidget {
  final ServiceModel service;
  final DynamicColors dc;
  const _ServiceDetails({required this.service, required this.dc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (service.isHighlight)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: dc.neonBlue.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '⭐  FLAGSHIP SERVICE',
              style: TextStyle(
                  color: dc.neonBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            ),
          ),
        Text(
          service.title,
          style: TextStyle(
            color: dc.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          service.fullDescription,
          style: TextStyle(color: dc.textSecondary, fontSize: 14, height: 1.7),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: service.benefits
              .map((b) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: dc.neonPurple.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: dc.neonPurple.withOpacity(0.2)),
                    ),
                    child: Text(b,
                        style:
                            TextStyle(color: dc.textSecondary, fontSize: 12)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// ─── Process Section ──────────────────────────────────────────────────────────

class _ProcessSection extends StatelessWidget {
  static const _steps = [
    (
      '01',
      'Discovery',
      Icons.search_outlined,
      'We analyse your current processes and identify high-ROI automation opportunities.'
    ),
    (
      '02',
      'Design',
      Icons.architecture_outlined,
      'Our architects design the automation workflow, bot logic, and integration blueprint.'
    ),
    (
      '03',
      'Build',
      Icons.construction_outlined,
      'Expert developers build, configure, and test your RPA bots in a sandbox environment.'
    ),
    (
      '04',
      'Deploy',
      Icons.rocket_launch_outlined,
      'Go live with monitoring, alerting, and SLA-backed support from day one.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 20, desktop: 100),
        vertical: 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [dc.surface, dc.background]
              : [dc.background, dc.surfaceLight],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          FadeInWidget(
            uniqueKey: 'process_title',
            child: const SectionTitle(
              badge: '🚀 OUR PROCESS',
              title: 'From Concept to\nLive Automation',
              subtitle:
                  'A proven 4-step methodology that delivers working automations in weeks, not months.',
            ),
          ),
          const SizedBox(height: 60),
          isMobile
              ? Column(
                  children: _steps
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FadeInWidget(
                              uniqueKey: 'step_${e.key}',
                              child: _StepCard(step: e.value),
                            ),
                          ))
                      .toList(),
                )
              : Row(
                  children: _steps
                      .asMap()
                      .entries
                      .map((e) => Expanded(
                            child: FadeInWidget(
                              uniqueKey: 'step_${e.key}',
                              delay: Duration(milliseconds: 100 * e.key),
                              child: _StepCard(step: e.value),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _StepCard extends StatefulWidget {
  final (String, String, IconData, String) step;
  const _StepCard({required this.step});

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
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
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [
                    dc.neonBlue.withOpacity(0.1),
                    dc.neonPurple.withOpacity(0.07),
                  ]
                : isDark
                    ? [dc.card, dc.surface]
                    : [dc.surface, dc.surfaceLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? dc.neonBlue.withOpacity(0.4) : dc.border,
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              blendMode: BlendMode.srcIn,
              child: Text(
                widget.step.$1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Icon(widget.step.$3, color: dc.neonBlue, size: 28),
            const SizedBox(height: 12),
            Text(
              widget.step.$2,
              style: TextStyle(
                  color: dc.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              widget.step.$4,
              style:
                  TextStyle(color: dc.textSecondary, fontSize: 14, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
