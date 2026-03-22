import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

const _kNavShadow = [
  BoxShadow(
    color: Color(0x40000000),
    blurRadius: 12,
    offset: Offset(0, 2),
  ),
];

const _kHoverDuration = Duration(milliseconds: 200);
const _kContactIndex = 5;

typedef _NavEntry = ({int index, String label});

List<_NavEntry> _buildNavEntries() => [
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
            _LogoButton(onTap: () => widget.onSectionTap(0)),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  for (final entry in entries)
                    _NavItem(
                      label: entry.label,
                      onTap: () => widget.onSectionTap(entry.index),
                    ),
                  const SizedBox(width: 12),
                  _NavCta(
                    label: t.hero.get_in_touch,
                    onTap: () => widget.onSectionTap(_kContactIndex),
                  ),
                ],
              )
            else
              _MobileMenuButton(
                entries: entries,
                onSectionTap: widget.onSectionTap,
              ),
          ],
        ),
      ),
    );
  }
}

class _LogoButton extends StatelessWidget {
  const _LogoButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Home',
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Assets.lib.app.assets.images.logo.image(height: 36),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
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

class _NavCta extends StatefulWidget {
  const _NavCta({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavCta> createState() => _NavCtaState();
}

class _NavCtaState extends State<_NavCta> {
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

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({
    required this.entries,
    required this.onSectionTap,
  });

  final List<_NavEntry> entries;
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
          value: _kContactIndex,
          child: Text(
            t.nav.contact,
            style: TextStyle(color: context.appColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
