import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';

const _kHoverDuration = Duration(milliseconds: 200);

class NavCta extends StatefulWidget {
  const NavCta({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  State<NavCta> createState() => _NavCtaState();
}

class _NavCtaState extends State<NavCta> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: _kHoverDuration,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: context.appColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: context.appColors.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
