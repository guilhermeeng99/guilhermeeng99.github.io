import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:my_portfolio/screens/home/home_page.dart';

class LoadingPage extends HookWidget {
  const LoadingPage({super.key});

  static const _kMinDisplayDuration = Duration(milliseconds: 1800);

  @override
  Widget build(BuildContext context) {
    final isReady = useState(false);
    final fadeOut = useState(false);

    useEffect(() {
      final stopwatch = Stopwatch()..start();

      Future<void> preload() async {
        await WidgetsBinding.instance.endOfFrame;
        if (!context.mounted) return;

        try {
          await _precacheImages(context);
        } on Exception catch (_) {}

        final elapsed = stopwatch.elapsed;
        if (elapsed < _kMinDisplayDuration) {
          await Future<void>.delayed(_kMinDisplayDuration - elapsed);
        }

        if (!context.mounted) return;
        fadeOut.value = true;

        await Future<void>.delayed(const Duration(milliseconds: 500));
        if (!context.mounted) return;
        isReady.value = true;
      }

      unawaited(preload());
      return null;
    }, const []);

    if (isReady.value) {
      return const HomePage();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedOpacity(
        opacity: fadeOut.value ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AnimatedLogo(),
              const SizedBox(height: 32),
              _LoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _precacheImages(BuildContext context) async {
    final images = Assets.lib.app.assets.images;
    final allImages = [
      images.logo,
      images.myProfile,
      ...images.projects.values,
    ];

    await Future.wait(
      allImages.map(
        (img) => precacheImage(
          img.provider(),
          context,
          onError: (_, _) {},
        ),
      ),
    );
  }
}

class _AnimatedLogo extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    final scaleAnim = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    final opacityAnim = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    useEffect(() {
      unawaited(
        Future.delayed(const Duration(milliseconds: 200), () {
          if (controller.isAnimating || controller.isCompleted) return;
          unawaited(controller.forward());
        }),
      );
      return null;
    }, const []);

    return Opacity(
      opacity: opacityAnim,
      child: Transform.scale(
        scale: 0.5 + (scaleAnim * 0.5),
        child: Assets.lib.app.assets.images.logo.image(
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}

class _LoadingIndicator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );

    final opacityAnim = useAnimation(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    useEffect(() {
      unawaited(
        Future.delayed(const Duration(milliseconds: 600), () {
          if (controller.isAnimating || controller.isCompleted) return;
          unawaited(controller.forward());
        }),
      );
      return null;
    }, const []);

    return Opacity(
      opacity: opacityAnim,
      child: SizedBox(
        width: 140,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: const LinearProgressIndicator(
                minHeight: 3,
                backgroundColor: AppColors.surfaceLight,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
