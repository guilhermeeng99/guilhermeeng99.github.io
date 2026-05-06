import 'dart:async';
import 'dart:io';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // GoogleFonts hits the network at runtime to fetch font files; in the test
  // environment we silence those requests by intercepting the HttpClient.
  // GoogleFonts catches the resulting failure and falls back to the default
  // font — visual fidelity isn't what these tests are asserting on.
  HttpOverrides.global = _SilentHttpOverrides();
  await testMain();
}

class _SilentHttpOverrides extends HttpOverrides {}
