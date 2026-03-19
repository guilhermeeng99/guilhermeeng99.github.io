import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:my_portfolio/app/routes/app_router.dart';
import 'package:my_portfolio/app/theme/app_colors.dart';
import 'package:my_portfolio/gen/assets.gen.dart';
import 'package:remote_config/remote_config.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  static const _kMinDisplayDuration = Duration(milliseconds: 1800);

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
      await Future.wait([
        _initializeRemoteConfig(),
        _precacheImages(),
      ]);
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

  Future<void> _initializeRemoteConfig() async {
    try {
      await context.read<RemoteConfigInitializeUseCase>().call();
    } on Exception catch (e) {
      Logger().e('Remote Config initialization failed', error: e);
    }
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
      backgroundColor: AppColors.background,
      body: AnimatedOpacity(
        opacity: _fadeOut ? 0.0 : 1.0,
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
}

class _AnimatedLogo extends StatefulWidget {
  @override
  State<_AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<_AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _opacityAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    unawaited(
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        if (_controller.isAnimating || _controller.isCompleted) return;
        unawaited(_controller.forward());
      }),
    );
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
          child: Transform.scale(
            scale: 0.5 + (_scaleAnim.value * 0.5),
            child: child,
          ),
        );
      },
      child: Assets.lib.app.assets.images.logo.image(
        width: 80,
        height: 80,
      ),
    );
  }
}

class _LoadingIndicator extends StatefulWidget {
  @override
  State<_LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<_LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _opacityAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1, curve: Curves.easeOut),
    );
    unawaited(
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        if (_controller.isAnimating || _controller.isCompleted) return;
        unawaited(_controller.forward());
      }),
    );
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
          child: child,
        );
      },
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
