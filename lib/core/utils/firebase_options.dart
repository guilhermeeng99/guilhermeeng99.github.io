import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions is not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBfGWlk8FHPJI955LdQXRi3weaUVCqlIhk',
    authDomain: 'portifolio-guilherme99.firebaseapp.com',
    projectId: 'portifolio-guilherme99',
    storageBucket: 'portifolio-guilherme99.firebasestorage.app',
    messagingSenderId: '975440661242',
    appId: '1:975440661242:web:8d6d225be9f71b8d555743',
    measurementId: 'G-J2CVFCB5KN',
  );
}
