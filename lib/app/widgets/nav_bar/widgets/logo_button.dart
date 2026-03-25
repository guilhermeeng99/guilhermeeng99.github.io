import 'package:flutter/material.dart';
import 'package:my_portfolio/gen/assets.gen.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Home',
      button: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Assets.lib.app.assets.images.logo.image(height: 36),
        ),
      ),
    );
  }
}
