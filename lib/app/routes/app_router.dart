import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/features/loading/presentation/pages/loading_page.dart';
import 'package:my_portfolio/features/portfolio/presentation/pages/home_page.dart';

abstract final class AppRoutes {
  static const String loading = '/';
  static const String home = '/home';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.loading,
  routes: [
    GoRoute(
      path: AppRoutes.loading,
      pageBuilder: (context, state) => const MaterialPage(
        child: LoadingPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    ),
  ],
);
