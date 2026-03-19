import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/url_launch.dart';

class SocialButton extends StatefulWidget {
  const SocialButton({
    required this.icon,
    required this.url,
    super.key,
    this.tooltip = '',
  });

  final Object icon;
  final String url;
  final String tooltip;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => appUrlLaunch(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : AppColors.cardBorder,
              ),
            ),
            child: widget.icon is FaIconData
                ? FaIcon(
                    widget.icon as FaIconData,
                    color: _hovered
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    size: 22,
                  )
                : Icon(
                    widget.icon as IconData,
                    color: _hovered
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    size: 22,
                  ),
          ),
        ),
      ),
    );
  }
}
