import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/nav_bar/widgets/logo_button.dart';
import 'package:my_portfolio/app/widgets/nav_bar/widgets/mobile_menu_button.dart';
import 'package:my_portfolio/app/widgets/nav_bar/widgets/nav_cta.dart';
import 'package:my_portfolio/app/widgets/nav_bar/widgets/nav_item.dart';
import 'package:my_portfolio/app/widgets/nav_bar/widgets/theme_toggle_button.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

const _kNavShadow = [
  BoxShadow(
    color: Color(0x40000000),
    blurRadius: 12,
    offset: Offset(0, 2),
  ),
];

List<NavEntry> _buildNavEntries() => [
  (index: 1, label: t.nav.about),
  (index: 2, label: t.nav.projects),
  (index: 3, label: t.nav.experience),
  (index: 4, label: t.nav.skills),
];

class NavBar extends StatefulWidget {
  const NavBar({
    required this.onSectionTap,
    required this.scrollController,
    super.key,
  });

  final void Function(int index) onSectionTap;
  final ScrollController scrollController;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final entries = _buildNavEntries();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: context.appColors.background,
        border: Border(
          bottom: BorderSide(
            color: context.appColors.divider,
          ),
        ),
        boxShadow: _kNavShadow,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            LogoButton(onTap: () => widget.onSectionTap(0)),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  for (final entry in entries)
                    NavItem(
                      label: entry.label,
                      onTap: () => widget.onSectionTap(entry.index),
                    ),
                  const SizedBox(width: 8),
                  const ThemeToggleButton(),
                  const SizedBox(width: 12),
                  NavCta(
                    label: t.hero.get_in_touch,
                    onTap: () => widget.onSectionTap(kNavContactIndex),
                  ),
                ],
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ThemeToggleButton(),
                  MobileMenuButton(
                    entries: entries,
                    onSectionTap: widget.onSectionTap,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
