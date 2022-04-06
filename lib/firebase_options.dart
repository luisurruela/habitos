// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyATpry6vcDhQKVXqPbAOVq_f-nEP2ldKhs',
    appId: '1:443723990346:web:d01eaa2b76ad7e24396db3',
    messagingSenderId: '443723990346',
    projectId: 'habitoskids-183cf',
    authDomain: 'habitoskids-183cf.firebaseapp.com',
    storageBucket: 'habitoskids-183cf.appspot.com',
    measurementId: 'G-WYHJL3SYNV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTtqlHDNxGWLP_inbzQOb_BDVOubQDgP4',
    appId: '1:443723990346:android:9dd62ccbddf25a2d396db3',
    messagingSenderId: '443723990346',
    projectId: 'habitoskids-183cf',
    storageBucket: 'habitoskids-183cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTLINPvE6xdjqIX8My3PtNQjJup477xHY',
    appId: '1:443723990346:ios:5091b3a6d8a4eac6396db3',
    messagingSenderId: '443723990346',
    projectId: 'habitoskids-183cf',
    storageBucket: 'habitoskids-183cf.appspot.com',
    iosClientId: '443723990346-bog4eg3paii81vie23uafv8qcs94e7e8.apps.googleusercontent.com',
    iosBundleId: 'habitos.kids.app',
  );
}
