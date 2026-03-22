import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/app/widgets/responsive_layout.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/utils/url_launch.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: ResponsiveLayout.sectionPadding(context),
      child: ResponsiveLayout(
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  context.appColors.primaryGradient.createShader(bounds),
              child: Text(
                t.contact.title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 32 : 48,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 500,
              child: Text(
                t.contact.subtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _ContactCard(
                  icon: Icons.email_outlined,
                  label: t.contact.email,
                  value: AppConstants.email,
                  url: AppConstants.emailUrl,
                ),
                _ContactCard(
                  icon: FontAwesomeIcons.github,
                  label: t.contact.github,
                  value: AppConstants.github,
                  url: AppConstants.githubUrl,
                ),
                _ContactCard(
                  icon: FontAwesomeIcons.linkedin,
                  label: t.contact.linkedin,
                  value: AppConstants.linkedin,
                  url: AppConstants.linkedinUrl,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Container(
              width: double.infinity,
              height: 1,
              color: context.appColors.divider,
            ),
            const SizedBox(height: 32),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${t.contact.footer} ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: context.appColors.textMuted,
                    ),
                  ),
                  const FlutterLogo(size: 16),
                  Text(
                    ' ${t.contact.flutter}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: context.appColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  final Object icon;
  final String label;
  final String value;
  final String url;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => appUrlLaunch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          decoration: BoxDecoration(
            gradient: context.appColors.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? context.appColors.primary.withValues(alpha: 0.5)
                  : context.appColors.cardBorder,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: context.appColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon is FaIconData)
                FaIcon(
                  widget.icon as FaIconData,
                  color: _hovered
                      ? context.appColors.primary
                      : context.appColors.textSecondary,
                  size: 28,
                )
              else
                Icon(
                  widget.icon as IconData,
                  color: _hovered
                      ? context.appColors.primary
                      : context.appColors.textSecondary,
                  size: 28,
                ),
              const SizedBox(height: 12),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                widget.value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: context.appColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
