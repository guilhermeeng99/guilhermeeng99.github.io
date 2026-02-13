import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/social_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onExploreProjects, required this.onContact});

  final VoidCallback onExploreProjects;
  final VoidCallback onContact;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CustomPaint(
                painter: _OrbPainter(_controller.value),
              ),
            ),
          ),
          Center(
            child: ResponsiveLayout(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  Text(
                    '// hello, world',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Guilherme\nPassos Mendes',
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
                      'Flutter Developer & Mobile Games Entrepreneur with 5+ years crafting high-performance apps and games reaching 15M+ downloads worldwide.',
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
                    alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                    children: [
                      _PrimaryButton(
                        label: 'Explore Projects',
                        onTap: widget.onExploreProjects,
                      ),
                      _OutlineButton(
                        label: 'Get In Touch',
                        onTap: widget.onContact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SocialButton(
                        icon: FontAwesomeIcons.github,
                        url: 'https://github.com/guilhermeeng99',
                        tooltip: 'GitHub',
                      ),
                      SizedBox(width: 12),
                      SocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        url: 'https://linkedin.com/in/guigapassos/',
                        tooltip: 'LinkedIn',
                      ),
                      SizedBox(width: 12),
                      SocialButton(
                        icon: Icons.email_outlined,
                        url: 'mailto:guilhermeeng99@gmail.com',
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

  Widget _buildGradientSubtitle(BuildContext context, bool isMobile) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
      child: Text(
        'Flutter Developer · Game Creator',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 20 : 28,
            ),
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  const _PrimaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
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

class _OutlineButton extends StatefulWidget {
  const _OutlineButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.cardBorder,
            ),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _hovered ? AppColors.primary : AppColors.textSecondary,
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
