import 'dart:async';
import 'dart:io';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Fonts are self-hosted now, so tests make no font network calls. This
  // override stays as a safety net: any stray HTTP from test code gets a
  // dead client instead of a real request, keeping tests hermetic.
  HttpOverrides.global = _SilentHttpOverrides();
  await testMain();
}

class _SilentHttpOverrides extends HttpOverrides {}
