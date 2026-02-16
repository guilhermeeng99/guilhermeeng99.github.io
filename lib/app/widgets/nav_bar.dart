import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class NavBar extends HookWidget {
  const NavBar({
    required this.onSectionTap,
    required this.scrollController,
    super.key,
  });

  final void Function(int index) onSectionTap;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final scrolled = useState(false);

    useEffect(() {
      void onScroll() {
        final shouldShow = scrollController.offset > 50;
        if (shouldShow != scrolled.value) {
          scrolled.value = shouldShow;
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    final isMobile = ResponsiveLayout.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: scrolled.value
            ? AppColors.background.withValues(alpha: 0.95)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: scrolled.value ? AppColors.divider : Colors.transparent,
          ),
        ),
        boxShadow: scrolled.value ? _kNavShadow : null,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onSectionTap(0),
                child: Assets.lib.app.assets.images.logo.image(height: 36),
              ),
            ),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  _NavItem(label: t.nav.about, onTap: () => onSectionTap(1)),
                  _NavItem(label: t.nav.projects, onTap: () => onSectionTap(2)),
                  _NavItem(
                    label: t.nav.experience,
                    onTap: () => onSectionTap(3),
                  ),
                  _NavItem(label: t.nav.skills, onTap: () => onSectionTap(4)),
                  _NavItem(label: t.nav.contact, onTap: () => onSectionTap(5)),
                  const SizedBox(width: 12),
                  _NavCta(
                    label: t.hero.getInTouch,
                    onTap: () => onSectionTap(5),
                  ),
                ],
              )
            else
              _MobileMenuButton(onSectionTap: onSectionTap),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends HookWidget {
  const _NavItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: hovered.value
                  ? AppColors.primary
                  : AppColors.textSecondary,
              fontSize: 14,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

class _NavCta extends HookWidget {
  const _NavCta({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: hovered.value
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
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
