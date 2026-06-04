import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders a social/contact icon that is either a Material [IconData] or a
/// brand SVG (a `String` asset path, see `BrandIcons`). Keeps the
/// "IconData or SVG path" branching in one place so callers just pass an
/// `Object` icon.
class SocialIcon extends StatelessWidget {
  const SocialIcon({
    required this.icon,
    required this.size,
    required this.color,
    super.key,
  });

  final Object icon;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final iconValue = icon;
    if (iconValue is String) {
      return SvgPicture.asset(
        iconValue,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    return Icon(iconValue as IconData, color: color, size: size);
  }
}
