import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';

class GlassCard extends StatefulWidget {
  const GlassCard({required this.child, super.key, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: widget.padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: context.appColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? context.appColors.primary.withValues(alpha: 0.4)
                : context.appColors.cardBorder,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: context.appColors.primary.withValues(alpha: 0.08),
                    blurRadius: 24,
                  ),
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
