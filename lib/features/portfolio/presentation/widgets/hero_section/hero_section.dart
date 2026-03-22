import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/features/portfolio/presentation/widgets/hero_section/widgets/hero_section_content.dart';
import 'package:my_portfolio/gen/assets.gen.dart';

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

class _BouncingArrow extends StatefulWidget {
  const _BouncingArrow();

  @override
  State<_BouncingArrow> createState() => _BouncingArrowState();
}

class _BouncingArrowState extends State<_BouncingArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    unawaited(_controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final bounce = math.sin(_controller.value * math.pi * 2) * 6;
        return Transform.translate(
          offset: Offset(0, bounce),
          child: child,
        );
      },
      child: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: context.appColors.textMuted,
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: SweepGradient(
          colors: [
            context.appColors.primary,
            context.appColors.secondary,
            context.appColors.accent,
            context.appColors.primary,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
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
