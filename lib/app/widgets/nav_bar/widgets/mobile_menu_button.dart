import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

typedef NavEntry = ({int index, String label});

const kNavContactIndex = 5;

class MobileMenuButton extends StatelessWidget {
  const MobileMenuButton({
    required this.entries,
    required this.onSectionTap,
    super.key,
  });

  final List<NavEntry> entries;
  final void Function(int index) onSectionTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      tooltip: 'Menu',
      icon: Icon(Icons.menu_rounded, color: context.appColors.textSecondary),
      color: context.appColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: onSectionTap,
      itemBuilder: (context) => [
        for (final entry in entries)
          PopupMenuItem(
            value: entry.index,
            child: Text(
              entry.label,
              style: TextStyle(color: context.appColors.textPrimary),
            ),
          ),
        PopupMenuItem(
          value: kNavContactIndex,
          child: Text(
            t.nav.contact,
            style: TextStyle(color: context.appColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
