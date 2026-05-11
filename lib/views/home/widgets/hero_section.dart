// lib/views/home/widgets/hero_section.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/common/custom_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _floatCtrl;
  late AnimationController _textCtrl;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();
    _pulseCtrl =
    AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _floatCtrl =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
    _textCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _textOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _textSlide = Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero)
        .animate(
        CurvedAnimation(parent: _textCtrl, curve: Curves.easeOutCubic));
    _textCtrl.forward();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _floatCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenH = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    // ── Mobile: natural height flow (no Positioned.fill) ──────────────────
    if (isMobile) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: dc.heroGradient),
        child: Stack(
          children: [
            // decorative bg (sized explicitly so Stack can measure them)
            _GlowOrb(
                ctrl: _pulseCtrl,
                top: -60,
                left: -60,
                size: 280,
                color: dc.neonBlue,
                opacity: 0.1),
            _GlowOrb(
                ctrl: _pulseCtrl,
                bottom: 40,
                right: -40,
                size: 220,
                color: dc.neonPurple,
                opacity: 0.08),
            // content — drives Stack height
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 60),
                child: AnimatedBuilder(
                  animation: _textCtrl,
                  builder: (_, child) => Transform.translate(
                    offset: _textSlide.value,
                    child: Opacity(opacity: _textOpacity.value, child: child),
                  ),
                  child: _HeroContent(isMobile: true, dc: dc),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ── Desktop / Tablet: fixed viewport height with Positioned layout ─────
    return Container(
      width: double.infinity,
      height: max(screenH, 700),
      decoration: BoxDecoration(gradient: dc.heroGradient),
      child: Stack(
        children: [
          Positioned.fill(child: _GridBackground(isDark: isDark)),
          Positioned(
              top: -100,
              left: -100,
              child: _GlowOrb(
                  ctrl: _pulseCtrl,
                  size: 500,
                  color: dc.neonBlue,
                  opacity: 0.1)),
          Positioned(
              bottom: 50,
              right: -80,
              child: _GlowOrb(
                  ctrl: _pulseCtrl,
                  size: 400,
                  color: dc.neonPurple,
                  opacity: 0.08)),
          Positioned.fill(
              child: CustomPaint(painter: _CircuitPainter(_pulseCtrl, isDark))),
          // Robot visual
          Positioned(
            right: isTablet ? 20 : 60,
            top: 0,
            bottom: 0,
            width: isTablet ? 340 : 480,
            child: AnimatedBuilder(
              animation: _floatCtrl,
              builder: (_, child) => Transform.translate(
                offset: Offset(0, sin(_floatCtrl.value * pi) * 12),
                child: child,
              ),
              child: _RobotIllustration(isDark: isDark),
            ),
          ),
          // Content
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.value(context,
                    mobile: 24, tablet: 40, desktop: 100),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: _textCtrl,
                    builder: (_, child) => Transform.translate(
                      offset: _textSlide.value,
                      child: Opacity(opacity: _textOpacity.value, child: child),
                    ),
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints(maxWidth: isTablet ? 440 : 620),
                      child: _HeroContent(isMobile: false, dc: dc),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom fade — must match the top of the section below (StatsSection)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    isDark ? Colors.transparent: Colors.blueAccent.withOpacity(0.1),
                    isDark ? dc.background : Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Mobile + Desktop shared content block ────────────────────────────────────

class _HeroContent extends StatelessWidget {
  final bool isMobile;
  final DynamicColors dc;
  const _HeroContent({required this.isMobile, required this.dc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BadgePill(dc: dc),
        const SizedBox(height: 24),
        _HeroHeadline(isMobile: isMobile),
        const SizedBox(height: 22),
        Text(
          'Deploy intelligent software robots that automate complex business '
              'processes, eliminate errors, and accelerate digital transformation — at scale.',
          style: TextStyle(
            color: dc.textSecondary,
            fontSize: isMobile ? 15 : 17,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            CustomButton(
              label: 'Explore Services',
              onTap: () => context.go(AppConstants.servicesRoute),
              icon: Icons.rocket_launch_outlined,
            ),
            CustomButton(
              label: 'Get Started',
              onTap: () => context.go(AppConstants.contactRoute),
              variant: ButtonVariant.outline,
              icon: Icons.arrow_forward,
            ),
          ],
        ),
        const SizedBox(height: 48),
        _TrustBadges(dc: dc),
      ],
    );
  }
}

// ─── Glow orb (positioned manually so Stack gets size from content) ───────────

class _GlowOrb extends StatelessWidget {
  final AnimationController ctrl;
  final double size;
  final Color color;
  final double opacity;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const _GlowOrb({
    required this.ctrl,
    required this.size,
    required this.color,
    required this.opacity,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    Widget orb = AnimatedBuilder(
      animation: ctrl,
      builder: (_, __) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(opacity + ctrl.value * 0.04),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
    if (top != null || bottom != null || left != null || right != null) {
      return Positioned(
          top: top, bottom: bottom, left: left, right: right, child: orb);
    }
    return orb;
  }
}

// ─── Badge pill ───────────────────────────────────────────────────────────────

class _BadgePill extends StatelessWidget {
  final DynamicColors dc;
  const _BadgePill({required this.dc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          dc.neonBlue.withOpacity(0.12),
          dc.neonPurple.withOpacity(0.12),
        ]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: dc.neonBlue.withOpacity(0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 7,
              height: 7,
              decoration:
              BoxDecoration(color: dc.neonCyan, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(
            '🤖  Next-Gen Robotic Process Automation',
            style: TextStyle(
              color: dc.neonBlue,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Headline ─────────────────────────────────────────────────────────────────

class _HeroHeadline extends StatelessWidget {
  final bool isMobile;
  const _HeroHeadline({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: isMobile ? 32 : 52,
          fontWeight: FontWeight.w800,
          height: 1.15,
          letterSpacing: -1,
        ),
        children: [
          TextSpan(
            text: 'Transforming\nBusinesses with\n',
            style: TextStyle(
                color: Theme.of(context).textTheme.headlineLarge?.color),
          ),
          WidgetSpan(
            child: ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              blendMode: BlendMode.srcIn,
              child: Text(
                'Intelligent\nRobotic Automation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 32 : 52,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: -1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Trust badges ─────────────────────────────────────────────────────────────

class _TrustBadges extends StatelessWidget {
  final DynamicColors dc;
  const _TrustBadges({required this.dc});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 24, runSpacing: 12, children: [
      _Badge(icon: Icons.verified_outlined, label: 'ISO Certified', dc: dc),
      _Badge(
          icon: Icons.security_outlined, label: 'Enterprise Security', dc: dc),
      _Badge(icon: Icons.speed_outlined, label: '10x Faster Ops', dc: dc),
    ]);
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final DynamicColors dc;
  const _Badge({required this.icon, required this.label, required this.dc});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 15, color: dc.neonCyan),
      const SizedBox(width: 6),
      Text(label, style: TextStyle(color: dc.textSecondary, fontSize: 13)),
    ]);
  }
}

// ─── Robot illustration ───────────────────────────────────────────────────────

class _RobotIllustration extends StatelessWidget {
  final bool isDark;
  const _RobotIllustration({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _RobotPainter(isDark));
  }
}

class _RobotPainter extends CustomPainter {
  final bool isDark;
  const _RobotPainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final blue = isDark ? AppColors.neonBlue : AppColorsLight.neonBlue;
    final purple = isDark ? AppColors.neonPurple : AppColorsLight.neonPurple;
    final cyan = isDark ? AppColors.neonCyan : AppColorsLight.neonCyan;
    final surf = isDark ? AppColors.surfaceLight : AppColorsLight.surfaceLight;

    // Outer glow ring
    canvas.drawCircle(
        Offset(cx, cy),
        size.width * 0.48,
        Paint()
          ..shader = RadialGradient(colors: [
            blue.withOpacity(0.15),
            Colors.transparent
          ]).createShader(
              Rect.fromCircle(center: Offset(cx, cy), radius: size.width * 0.5))
          ..style = PaintingStyle.fill);

    // Rings
    canvas.drawCircle(
        Offset(cx, cy),
        size.width * 0.42,
        Paint()
          ..color = blue.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
    _drawDashedCircle(
        canvas,
        Offset(cx, cy),
        size.width * 0.38,
        Paint()
          ..color = purple.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8);

    // Head hexagon
    _drawHexagon(
        canvas,
        Offset(cx, cy - 50),
        85,
        Paint()
          ..shader = LinearGradient(
              colors: [blue.withOpacity(0.8), purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
              .createShader(Rect.fromLTWH(cx - 80, cy - 120, 160, 140)));
    _drawHexagon(
        canvas,
        Offset(cx, cy - 50),
        75,
        Paint()
          ..shader = LinearGradient(colors: [
            surf,
            isDark ? AppColors.surface : AppColorsLight.surface
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              .createShader(Rect.fromLTWH(cx - 70, cy - 130, 140, 120)));

    // Eyes
    final eyePaint = Paint()
      ..shader = RadialGradient(colors: [cyan, blue])
          .createShader(Rect.fromLTWH(cx - 50, cy - 80, 100, 30));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx - 22, cy - 55), width: 32, height: 14),
            const Radius.circular(7)),
        eyePaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx + 22, cy - 55), width: 32, height: 14),
            const Radius.circular(7)),
        eyePaint);

    // Antenna
    canvas.drawLine(
        Offset(cx, cy - 135),
        Offset(cx, cy - 160),
        Paint()
          ..color = blue.withOpacity(0.6)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(cx, cy - 163),
        6,
        Paint()
          ..color = cyan
          ..style = PaintingStyle.fill);

    // Chest panel
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, cy + 40), width: 100, height: 70),
            const Radius.circular(10)),
        Paint()..color = blue.withOpacity(0.12));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, cy + 40), width: 100, height: 70),
            const Radius.circular(10)),
        Paint()
          ..color = blue.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(Offset(cx - 25 + i * 25.0, cy + 35), 5,
          Paint()..color = blue.withOpacity(0.6));
    }

    // Body
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, cy + 65), width: 150, height: 100),
            const Radius.circular(14)),
        Paint()
          ..shader = LinearGradient(
              colors: [blue.withOpacity(0.5), purple.withOpacity(0.4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
              .createShader(Rect.fromLTWH(cx - 80, cy + 10, 160, 120)));
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: Offset(cx, cy + 65), width: 150, height: 100),
            const Radius.circular(14)),
        Paint()
          ..color = (isDark ? Colors.white : Colors.black).withOpacity(0.12)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);

    // Arms
    _drawArm(canvas, cx, cy, left: true, blue: blue);
    _drawArm(canvas, cx, cy, left: false, blue: blue);

    // Floating data nodes
    _drawDataNode(canvas, Offset(cx - 150, cy - 80), 18,
        blue: blue, cyan: cyan, purple: purple);
    _drawDataNode(canvas, Offset(cx + 170, cy + 20), 14,
        blue: blue, cyan: cyan, purple: purple);
    _drawDataNode(canvas, Offset(cx - 140, cy + 80), 12,
        blue: blue, cyan: cyan, purple: purple);
    _drawDataNode(canvas, Offset(cx + 155, cy - 100), 10,
        blue: blue, cyan: cyan, purple: purple);

    // Connection lines
    final lp = Paint()
      ..color = blue.withOpacity(0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx - 80, cy - 50), Offset(cx - 132, cy - 80), lp);
    canvas.drawLine(Offset(cx + 80, cy + 20), Offset(cx + 156, cy + 20), lp);
    canvas.drawLine(Offset(cx - 80, cy + 65), Offset(cx - 128, cy + 80), lp);
    canvas.drawLine(Offset(cx + 75, cy - 70), Offset(cx + 145, cy - 100), lp);
  }

  void _drawArm(Canvas canvas, double cx, double cy,
      {required bool left, required Color blue}) {
    final sign = left ? -1 : 1;
    final path = Path()
      ..moveTo(cx + sign * 75, cy + 30)
      ..cubicTo(cx + sign * 110, cy + 20, cx + sign * 120, cy + 60,
          cx + sign * 115, cy + 100);
    canvas.drawPath(
        path,
        Paint()
          ..color = blue.withOpacity(0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.round);
    canvas.drawPath(
        path,
        Paint()
          ..color = blue.withOpacity(0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 18
          ..strokeCap = StrokeCap.round);
    canvas.drawCircle(
        Offset(cx + sign * 115.0, cy + 100),
        16,
        Paint()
          ..shader = RadialGradient(colors: [
            isDark ? AppColors.neonCyan : AppColorsLight.neonCyan,
            blue
          ]).createShader(Rect.fromCircle(
              center: Offset(cx + sign * 115.0, cy + 100), radius: 16)));
  }

  void _drawHexagon(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i - pi / 6;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawDataNode(Canvas canvas, Offset center, double r,
      {required Color blue, required Color cyan, required Color purple}) {
    canvas.drawCircle(center, r, Paint()..color = purple.withOpacity(0.25));
    canvas.drawCircle(
        center,
        r,
        Paint()
          ..color = purple.withOpacity(0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
    canvas.drawCircle(center, r * 0.4, Paint()..color = cyan.withOpacity(0.7));
  }

  void _drawDashedCircle(
      Canvas canvas, Offset center, double radius, Paint paint) {
    const dashCount = 40;
    const dashLength = 0.08;
    for (int i = 0; i < dashCount; i++) {
      final start = (2 * pi / dashCount) * i;
      final path = Path()
        ..moveTo(
            center.dx + radius * cos(start), center.dy + radius * sin(start))
        ..arcTo(Rect.fromCircle(center: center, radius: radius), start,
            dashLength, false);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RobotPainter old) => old.isDark != isDark;
}

// ─── Grid background ──────────────────────────────────────────────────────────

class _GridBackground extends StatelessWidget {
  final bool isDark;
  const _GridBackground({required this.isDark});

  @override
  Widget build(BuildContext context) =>
      CustomPaint(painter: _GridPainter(isDark));
}

class _GridPainter extends CustomPainter {
  final bool isDark;
  const _GridPainter(this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final color = isDark
        ? AppColors.neonBlue.withOpacity(0.04)
        : AppColorsLight.neonBlue.withOpacity(0.06);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) => old.isDark != isDark;
}

// ─── Circuit painter ──────────────────────────────────────────────────────────

class _CircuitPainter extends CustomPainter {
  final Animation<double> animation;
  final bool isDark;
  _CircuitPainter(this.animation, this.isDark) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final blue = isDark ? AppColors.neonBlue : AppColorsLight.neonBlue;
    final paint = Paint()
      ..color = blue.withOpacity(0.06 + animation.value * 0.03)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paths = [
      _p(size, 0.1, 0.3, 0.25, 0.3, 0.25, 0.6, 0.4, 0.6),
      _p(size, 0.7, 0.1, 0.7, 0.35, 0.85, 0.35, 0.85, 0.55),
      _p(size, 0.05, 0.7, 0.2, 0.7, 0.2, 0.85, 0.35, 0.85),
    ];
    for (final path in paths) canvas.drawPath(path, paint);
  }

  Path _p(Size s, double x1, double y1, double x2, double y2, double x3,
      double y3, double x4, double y4) =>
      Path()
        ..moveTo(s.width * x1, s.height * y1)
        ..lineTo(s.width * x2, s.height * y2)
        ..lineTo(s.width * x3, s.height * y3)
        ..lineTo(s.width * x4, s.height * y4);

  @override
  bool shouldRepaint(covariant _CircuitPainter old) => true;
}