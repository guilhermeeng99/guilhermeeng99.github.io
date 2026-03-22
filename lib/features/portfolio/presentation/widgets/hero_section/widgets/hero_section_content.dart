import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/social_button.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class HeroSectionContent extends StatelessWidget {
  const HeroSectionContent({
    required this.isMobile,
    required this.onExploreProjects,
    required this.onContact,
    super.key,
  });

  final bool isMobile;
  final VoidCallback onExploreProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        _GradientSubtitle(isMobile: isMobile),
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
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _PrimaryButton(
              label: t.hero.explore_projects,
              onTap: onExploreProjects,
            ),
            _OutlineButton(
              label: t.hero.get_in_touch,
              onTap: onContact,
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SocialButton(
              icon: FontAwesomeIcons.github,
              url: AppConstants.githubUrl,
              tooltip: 'GitHub',
            ),
            SizedBox(width: 12),
            SocialButton(
              icon: FontAwesomeIcons.linkedin,
              url: AppConstants.linkedinUrl,
              tooltip: 'LinkedIn',
            ),
            SizedBox(width: 12),
            SocialButton(
              icon: Icons.email_outlined,
              url: AppConstants.emailUrl,
              tooltip: 'Email',
            ),
          ],
        ),
      ],
    );
  }
}

class _GradientSubtitle extends StatelessWidget {
  const _GradientSubtitle({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          context.appColors.primaryGradient.createShader(bounds),
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
            gradient: context.appColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: context.appColors.primary.withValues(alpha: 0.4),
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
            color: _hovered
                ? context.appColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? context.appColors.primary
                  : context.appColors.cardBorder,
            ),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: _hovered
                  ? context.appColors.primary
                  : context.appColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
