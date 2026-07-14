import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/core/utils/url_launch.dart';

/// Clickable credential / verification badge (e.g. Toptal "Top 3% Talent",
/// "Arc Certified Developer").
///
/// Styled to match the GlassCard look so it sits naturally next to the
/// About-section stats. Opens [url] in a new tab when tapped.
class CredentialBadge extends StatefulWidget {
  const CredentialBadge({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.url,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String url;

  @override
  State<CredentialBadge> createState() => _CredentialBadgeState();
}

class _CredentialBadgeState extends State<CredentialBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      link: true,
      label: '${widget.title}, ${widget.subtitle}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => appUrlLaunch(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: colors.cardGradient,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? colors.secondary.withValues(alpha: 0.5)
                    : colors.cardBorder,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: colors.secondary.withValues(alpha: 0.12),
                        blurRadius: 24,
                      ),
                    ]
                  : const [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: colors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.title,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 14,
                          color: colors.textMuted,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
