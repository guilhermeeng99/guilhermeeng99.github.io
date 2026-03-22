import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';
import 'package:my_portfolio/core/utils/url_launch.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

class ResumeSectionDownloadResumeButton extends StatefulWidget {
  const ResumeSectionDownloadResumeButton({super.key});

  @override
  State<ResumeSectionDownloadResumeButton> createState() =>
      _ResumeSectionDownloadResumeButtonState();
}

class _ResumeSectionDownloadResumeButtonState
    extends State<ResumeSectionDownloadResumeButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final remote = context.read<RemoteConstants>();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => appUrlLaunch(remote.resumeUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: _hovering ? context.appColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering
                  ? Colors.transparent
                  : context.appColors.primary.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 20,
                color: _hovering ? Colors.white : context.appColors.primary,
              ),
              const SizedBox(width: 12),
              Text(
                t.resume.download_resume,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _hovering ? Colors.white : context.appColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
