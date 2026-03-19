import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

final _logger = Logger();

Future<void> appUrlLaunch(String url) async {
  try {
    await _urlLaunch(url);
  } on Exception catch (_) {
    try {
      await _urlLaunch(
        url,
        mode: LaunchMode.externalApplication,
      );
    } on Exception catch (e) {
      _logger.e('Could not launch $url', error: e);
    }
  }
}

Future<void> _urlLaunch(
  String url, {
  LaunchMode mode = LaunchMode.platformDefault,
  WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
  BrowserConfiguration browserConfiguration = const BrowserConfiguration(),
  String? webOnlyWindowName,
}) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: mode,
    webViewConfiguration: webViewConfiguration,
    browserConfiguration: browserConfiguration,
    webOnlyWindowName: webOnlyWindowName,
  )) {
    throw Exception('Could not launch $uri');
  }
}
