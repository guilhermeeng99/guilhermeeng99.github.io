import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';
import 'package:web/web.dart' as web;

class ResumeSectionDownloadResumeButton extends HookWidget {
  const ResumeSectionDownloadResumeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final hovering = useState(false);

    Future<void> downloadResume() async {
      final byteData = await rootBundle.load(
        Assets.lib.app.assets.pdfs.guilhermePassosResume,
      );
      final bytes = byteData.buffer.asUint8List();
      final blob = web.Blob(
        [bytes.toJS].toJS,
        web.BlobPropertyBag(type: 'application/pdf'),
      );
      final url = web.URL.createObjectURL(blob);
      web.window.open(url, '_blank');
    }

    return MouseRegion(
      onEnter: (_) => hovering.value = true,
      onExit: (_) => hovering.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: downloadResume,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: hovering.value ? AppColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: hovering.value
                  ? Colors.transparent
                  : AppColors.primary.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.download_rounded,
                size: 20,
                color: hovering.value ? Colors.white : AppColors.primary,
              ),
              const SizedBox(width: 12),
              Text(
                t.resume.download_resume,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: hovering.value ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
