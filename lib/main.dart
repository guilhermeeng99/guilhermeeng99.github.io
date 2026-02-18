import 'package:flutter/material.dart';
import 'package:my_portfolio/app/app_widget.dart';
import 'package:my_portfolio/gen/i18n/strings.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocaleSync();
  runApp(TranslationProvider(child: const AppWidget()));
}
