import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButton extends HookWidget {
  const SocialButton({
    required this.icon, required this.url, super.key,
    this.tooltip = '',
  });

  final IconData icon;
  final String url;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        onEnter: (_) => hovered.value = true,
        onExit: (_) => hovered.value = false,
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(url)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: hovered.value
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hovered.value
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : AppColors.cardBorder,
              ),
            ),
            child: Icon(
              icon,
              color: hovered.value
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
