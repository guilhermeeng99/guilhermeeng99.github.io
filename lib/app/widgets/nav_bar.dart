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
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = widget.scrollController.offset > 50;
    if (shouldShow != _scrolled) {
      setState(() => _scrolled = shouldShow);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.background.withValues(alpha: 0.95)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.divider : Colors.transparent,
          ),
        ),
        boxShadow: _scrolled ? _kNavShadow : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => widget.onSectionTap(0),
                child: Assets.lib.app.assets.images.logo.image(height: 36),
              ),
            ),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  _NavItem(
                    label: t.nav.about,
                    onTap: () => widget.onSectionTap(1),
                  ),
                  _NavItem(
                    label: t.nav.projects,
                    onTap: () => widget.onSectionTap(2),
                  ),
                  _NavItem(
                    label: t.nav.experience,
                    onTap: () => widget.onSectionTap(3),
                  ),
                  _NavItem(
                    label: t.nav.skills,
                    onTap: () => widget.onSectionTap(4),
                  ),
                  const SizedBox(width: 12),
                  _NavCta(
                    label: t.hero.get_in_touch,
                    onTap: () => widget.onSectionTap(5),
                  ),
                ],
              )
            else
              _MobileMenuButton(onSectionTap: widget.onSectionTap),
          ],
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
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: _hovered
                  ? AppColors.primary
                  : AppColors.textSecondary,
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
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
  const _MobileMenuButton({required this.onSectionTap});

  final void Function(int index) onSectionTap;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textSecondary),
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: onSectionTap,
      itemBuilder: (context) => [
        _menuItem(1, t.nav.about),
        _menuItem(2, t.nav.projects),
        _menuItem(3, t.nav.experience),
        _menuItem(4, t.nav.skills),
        _menuItem(5, t.nav.contact),
      ],
    );
  }

  PopupMenuItem<int> _menuItem(int value, String label) {
    return PopupMenuItem(
      value: value,
      child: Text(label, style: const TextStyle(color: AppColors.textPrimary)),
    );
  }
}
