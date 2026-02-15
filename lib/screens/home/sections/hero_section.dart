import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/app/app_constants.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/app/widgets/social_button.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class HeroSection extends HookWidget {
  const HeroSection({
    required this.onExploreProjects,
    required this.onContact,
    super.key,
  });

  final VoidCallback onExploreProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 8),
    );

    useEffect(() {
      unawaited(controller.repeat());
      return null;
    }, const []);

    final isMobile = ResponsiveLayout.isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) =>
                  CustomPaint(painter: _OrbPainter(controller.value)),
            ),
          ),
          Center(
            child: ResponsiveLayout(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    t.hero.name,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 42 : 72,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  _buildGradientSubtitle(context, isMobile),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: isMobile ? double.infinity : 560,
                    child: Text(
                      t.hero.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: isMobile ? 15 : 18,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: isMobile
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    children: [
                      _PrimaryButton(
                        label: t.hero.exploreProjects,
                        onTap: onExploreProjects,
                      ),
                      _OutlineButton(
                        label: t.hero.getInTouch,
                        onTap: onContact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SocialButton(
                        icon: FontAwesomeIcons.github,
                        url: AppConstants.githubUrl,
                        tooltip: 'GitHub',
                      ),
                      const SizedBox(width: 12),
                      SocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        url: AppConstants.linkedinUrl,
                        tooltip: 'LinkedIn',
                      ),
                      const SizedBox(width: 12),
                      SocialButton(
                        icon: Icons.email_outlined,
                        url: AppConstants.emailUrl,
                        tooltip: 'Email',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedBuilder(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGradientSubtitle(BuildContext context, bool isMobile) {
  return ShaderMask(
    shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
    child: Text(
      t.hero.role,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: Colors.white,
        fontSize: isMobile ? 20 : 28,
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.left,
    ),
  );
}

class _PrimaryButton extends HookWidget {
  const _PrimaryButton({required this.label, required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: hovered.value
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends HookWidget {
  const _OutlineButton({required this.label, required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: hovered.value
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hovered.value ? AppColors.primary : AppColors.cardBorder,
            ),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: hovered.value
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter(this.animationValue);

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animationValue * math.pi * 2;

    _drawOrb(
      canvas,
      Offset(
        size.width * 0.75 + math.cos(t) * 60,
        size.height * 0.3 + math.sin(t * 0.7) * 40,
      ),
      180,
      AppColors.primary.withValues(alpha: 0.06),
    );

    _drawOrb(
      canvas,
      Offset(
        size.width * 0.2 + math.sin(t * 0.5) * 40,
        size.height * 0.7 + math.cos(t * 0.8) * 50,
      ),
      140,
      AppColors.secondary.withValues(alpha: 0.04),
    );

    _drawOrb(
      canvas,
      Offset(
        size.width * 0.6 + math.cos(t * 0.3) * 30,
        size.height * 0.6 + math.sin(t * 0.6) * 35,
      ),
      100,
      AppColors.accent.withValues(alpha: 0.05),
    );
  }

  void _drawOrb(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_OrbPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
