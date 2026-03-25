import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';

const _kHoverDuration = Duration(milliseconds: 200);

class NavItem extends StatefulWidget {
  const NavItem({required this.label, required this.onTap, super.key});

  final String label;
  final VoidCallback onTap;

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: _kHoverDuration,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: _hovered
                  ? context.appColors.primary
                  : context.appColors.textSecondary,
              fontSize: 14,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
