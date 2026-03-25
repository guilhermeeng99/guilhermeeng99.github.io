import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/theme/theme_cubit.dart';

const _kHoverDuration = Duration(milliseconds: 200);

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<ThemeCubit>().toggleTheme(),
        child: AnimatedContainer(
          duration: _kHoverDuration,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hovered
                ? context.appColors.surfaceLight
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              key: ValueKey(isDark),
              color: isDark
                  ? context.appColors.secondary
                  : context.appColors.primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
