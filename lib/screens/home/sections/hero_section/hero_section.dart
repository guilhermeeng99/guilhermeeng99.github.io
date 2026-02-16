import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/screens/home/sections/hero_section/widgets/hero_section_content.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.onExploreProjects,
    required this.onContact,
    super.key,
  });

  final VoidCallback onExploreProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Stack(
        children: [
          Center(
            child: ResponsiveLayout(
              child: isMobile
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 80),
                        const _ProfileAvatar(size: 180),
                        const SizedBox(height: 32),
                        HeroSectionContent(
                          isMobile: true,
                          onExploreProjects: onExploreProjects,
                          onContact: onContact,
                        ),
                        const SizedBox(height: 64),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 115),
                      child: Row(
                        children: [
                          Expanded(
                            child: HeroSectionContent(
                              isMobile: false,
                              onExploreProjects: onExploreProjects,
                              onContact: onContact,
                            ),
                          ),
                          const SizedBox(width: 48),
                          const _ProfileAvatar(size: 280),
                        ],
                      ),
                    ),
            ),
          ),
          const Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: _BouncingArrow(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BouncingArrow extends HookWidget {
  const _BouncingArrow();

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    useEffect(() {
      unawaited(controller.repeat());
      return null;
    }, const []);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final bounce = math.sin(controller.value * math.pi * 2) * 6;
        return Transform.translate(
          offset: Offset(0, bounce),
          child: child,
        );
      },
      child: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textMuted,
        size: 32,
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 8,
      height: size + 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.accent,
            AppColors.primary,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipOval(
          child: Assets.lib.app.assets.images.myProfile.image(
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
