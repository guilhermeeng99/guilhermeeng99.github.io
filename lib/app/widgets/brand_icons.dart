/// Asset paths for brand logos rendered as SVGs (via `flutter_svg`).
///
/// Only GitHub and LinkedIn are needed, so we vendor two tiny single-path SVGs
/// instead of pulling the full `font_awesome_flutter` package (which bundled
/// ~0.5MB of unused Solid/Regular icon fonts). Pass these paths to
/// `SocialButton` / contact cards, which render a string `icon` as an SVG.
abstract final class BrandIcons {
  static const String github = 'lib/app/assets/icons/github.svg';
  static const String linkedin = 'lib/app/assets/icons/linkedin.svg';
}
