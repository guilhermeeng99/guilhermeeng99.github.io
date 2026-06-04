import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/social_icon.dart';
import 'package:my_portfolio/core/utils/url_launch.dart';

class SocialButton extends StatefulWidget {
  const SocialButton({
    required this.icon,
    required this.url,
    super.key,
    this.tooltip = '',
  });

  /// Either an [IconData] (Material icon) or a `String` SVG asset path (brand
  /// logo, see `BrandIcons`).
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
                  ? context.appColors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered
                    ? context.appColors.primary.withValues(alpha: 0.4)
                    : context.appColors.cardBorder,
              ),
            ),
            child: SocialIcon(
              icon: widget.icon,
              size: 22,
              color: _hovered
                  ? context.appColors.primary
                  : context.appColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
