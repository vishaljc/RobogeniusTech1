// lib/widgets/common/custom_button.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum ButtonVariant { primary, secondary, outline, ghost }

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final IconData? icon;
  final bool loading;
  final double? width;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.width,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.loading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: _decoration,
          child: widget.loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 18, color: _textColor(dc)),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: _textColor(dc),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  BoxDecoration get _decoration {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return BoxDecoration(
          gradient: AppColors.buttonGradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: AppColors.neonBlue.withOpacity(0.45),
                      blurRadius: 24,
                      spreadRadius: 2)
                ]
              : [
                  BoxShadow(
                      color: AppColors.neonBlue.withOpacity(0.15),
                      blurRadius: 12)
                ],
        );
      case ButtonVariant.secondary:
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final dc = DynamicColors(isDark);
        return BoxDecoration(
          color: dc.neonPurple.withOpacity(_hovered ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: dc.neonPurple.withOpacity(0.5), width: 1),
        );
      case ButtonVariant.outline:
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final dc = DynamicColors(isDark);
        return BoxDecoration(
          color: _hovered ? dc.neonBlue.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: _hovered ? dc.neonBlue : dc.border, width: 1.5),
        );
      case ButtonVariant.ghost:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _hovered ? Colors.white.withOpacity(0.05) : Colors.transparent,
        );
    }
  }

  Color _textColor(DynamicColors dc) {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.secondary:
        return dc.neonPurple;
      case ButtonVariant.outline:
        return _hovered ? dc.neonBlue : dc.textPrimary;
      case ButtonVariant.ghost:
        return dc.textSecondary;
    }
  }
}
