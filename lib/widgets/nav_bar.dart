import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.onSectionTap,
    required this.scrollController,
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
        color: _scrolled ? AppColors.background.withValues(alpha: 0.9) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.divider : Colors.transparent,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => widget.onSectionTap(0),
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    'GPM',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            if (!isMobile)
              Row(
                children: [
                  _NavItem(label: 'About', onTap: () => widget.onSectionTap(1)),
                  _NavItem(label: 'Projects', onTap: () => widget.onSectionTap(2)),
                  _NavItem(label: 'Experience', onTap: () => widget.onSectionTap(3)),
                  _NavItem(label: 'Skills', onTap: () => widget.onSectionTap(4)),
                  _NavItem(label: 'Contact', onTap: () => widget.onSectionTap(5)),
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
                  color: _hovered ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 14,
                ),
            child: Text(widget.label),
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
        _menuItem(1, 'About'),
        _menuItem(2, 'Projects'),
        _menuItem(3, 'Experience'),
        _menuItem(4, 'Skills'),
        _menuItem(5, 'Contact'),
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
