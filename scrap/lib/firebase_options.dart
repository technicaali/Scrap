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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDDKnOCasCnnGuerCI0W9K2EhzSc6q8Izk',
    appId: '1:282503676697:web:371fda2670f1431b7cfb88',
    messagingSenderId: '282503676697',
    projectId: 'scrap-project2',
    authDomain: 'scrap-project2.firebaseapp.com',
    storageBucket: 'scrap-project2.appspot.com',
    measurementId: 'G-C0D66HRRLG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7Qmk9AEp-iYAw2UEpViPBeqaTiEymI68',
    appId: '1:282503676697:android:efdd1f72669af2a97cfb88',
    messagingSenderId: '282503676697',
    projectId: 'scrap-project2',
    storageBucket: 'scrap-project2.appspot.com',
  );
}