import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class SocialButton extends StatefulWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.url,
    this.tooltip = '',
  });

  final IconData icon;
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
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered ? AppColors.primary.withValues(alpha: 0.4) : AppColors.cardBorder,
              ),
            ),
            child: Icon(
              widget.icon,
              color: _hovered ? AppColors.primary : AppColors.textSecondary,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
