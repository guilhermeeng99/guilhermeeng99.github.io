import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/responsive_layout.dart';

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
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                'Let\'s Work Together',
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
                'Have a project in mind or want to discuss opportunities? I\'m always open to new challenges and collaborations.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: const [
                _ContactCard(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: 'guilhermeeng99@gmail.com',
                  url: 'mailto:guilhermeeng99@gmail.com',
                ),
                _ContactCard(
                  icon: FontAwesomeIcons.github,
                  label: 'GitHub',
                  value: 'guilhermeeng99',
                  url: 'https://github.com/guilhermeeng99',
                ),
                _ContactCard(
                  icon: FontAwesomeIcons.linkedin,
                  label: 'LinkedIn',
                  value: 'guigapassos',
                  url: 'https://linkedin.com/in/guigapassos/',
                ),
              ],
            ),
            const SizedBox(height: 80),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.divider,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© 2026 Guilherme Passos Mendes. Built with ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                ),
                const FlutterLogo(size: 16),
                Text(
                  ' Flutter.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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

  final IconData icon;
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
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.cardBorder,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _hovered ? AppColors.primary : AppColors.textSecondary,
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
                      color: AppColors.textMuted,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
