import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/app/routes/app_router.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/gen/assets.gen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  static const _kMinDisplayDuration = Duration(milliseconds: 700);

  bool _fadeOut = false;

  @override
  void initState() {
    super.initState();
    unawaited(_preload());
  }

  Future<void> _preload() async {
    final stopwatch = Stopwatch()..start();

    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    try {
      await _precacheImages();
    } on Exception catch (_) {}

    final elapsed = stopwatch.elapsed;
    if (elapsed < _kMinDisplayDuration) {
      await Future<void>.delayed(_kMinDisplayDuration - elapsed);
    }

    if (!mounted) return;
    setState(() => _fadeOut = true);

    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  Future<void> _precacheImages() async {
    final images = Assets.lib.app.assets.images;

    await precacheImage(
      images.myProfile.provider(),
      context,
      onError: (_, _) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: AnimatedOpacity(
        opacity: _fadeOut ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BreathingLogo(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Gently breathing GP logo. Mirrors the HTML splash logo (same size + pulse)
/// so the handoff from the browser-painted splash to this Flutter screen is
/// seamless — one continuous logo, never a second "logo appears" moment.
class _BreathingLogo extends StatefulWidget {
  @override
  State<_BreathingLogo> createState() => _BreathingLogoState();
}

class _BreathingLogoState extends State<_BreathingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _scaleAnim = Tween<double>(begin: 0.94, end: 1.04).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnim = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    unawaited(_controller.repeat(reverse: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnim.value,
          child: Transform.scale(scale: _scaleAnim.value, child: child),
        );
      },
      child: Assets.lib.app.assets.images.logo.image(
        width: 88,
        height: 88,
      ),
    );
  }
}
