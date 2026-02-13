import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.child});

  final Widget child;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return 1100;
    if (width >= 1024) return width * 0.85;
    if (width >= 600) return width * 0.9;
    return width * 0.92;
  }

  static EdgeInsets sectionPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.symmetric(vertical: 60);
    return const EdgeInsets.symmetric(vertical: 100);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: contentWidth(context),
        child: child,
      ),
    );
  }
}
