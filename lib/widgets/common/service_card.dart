// lib/widgets/common/service_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/service_model.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel service;
  final bool compact;

  const ServiceCard({
    super.key,
    required this.service,
    this.compact = false,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(AppConstants.servicesRoute),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -6.0))
              : Matrix4.identity(),
          padding: EdgeInsets.all(widget.compact ? 20 : 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovered
                  ? [
                      dc.neonBlue.withOpacity(0.12),
                      dc.neonPurple.withOpacity(0.08),
                    ]
                  : [
                      dc.card,
                      dc.surface,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? dc.neonBlue.withOpacity(0.4) : dc.border,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: dc.neonBlue.withOpacity(0.12),
                      blurRadius: 30,
                      spreadRadius: 4,
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: _hovered
                      ? AppColors.buttonGradient
                      : LinearGradient(
                          colors: [
                            dc.neonBlue.withOpacity(0.15),
                            dc.neonPurple.withOpacity(0.1),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.service.icon,
                  color: _hovered ? Colors.white : dc.neonBlue,
                  size: 26,
                ),
              ),
              const SizedBox(height: 18),
              // Title
              Text(
                widget.service.title,
                style: TextStyle(
                  color: dc.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                widget.service.shortDescription,
                style: TextStyle(
                  color: dc.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              if (!widget.compact) ...[
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      'Learn More',
                      style: TextStyle(
                        color: _hovered ? dc.neonBlue : dc.textMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward,
                      size: 14,
                      color: _hovered ? dc.neonBlue : dc.textMuted,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
