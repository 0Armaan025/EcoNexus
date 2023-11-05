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
        return macos;
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
    apiKey: 'AIzaSyCSwpL7b6SN2jhr5mLomTXYLwTI7y1Epkk',
    appId: '1:358189430330:web:3c63532fc90b4042f52703',
    messagingSenderId: '358189430330',
    projectId: 'econexus',
    authDomain: 'econexus.firebaseapp.com',
    storageBucket: 'econexus.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBprBg4om0CCjquCrM2FXX4P1vfrtNB1Lo',
    appId: '1:358189430330:android:dd724295d04e4f7df52703',
    messagingSenderId: '358189430330',
    projectId: 'econexus',
    storageBucket: 'econexus.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDma8qiBz4xqx5-ktXbWjXHSnI5ujleTZ4',
    appId: '1:358189430330:ios:4538117b9c6d5daef52703',
    messagingSenderId: '358189430330',
    projectId: 'econexus',
    storageBucket: 'econexus.appspot.com',
    iosBundleId: 'com.example.econexus',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDma8qiBz4xqx5-ktXbWjXHSnI5ujleTZ4',
    appId: '1:358189430330:ios:e3098b23036c8ac8f52703',
    messagingSenderId: '358189430330',
    projectId: 'econexus',
    storageBucket: 'econexus.appspot.com',
    iosBundleId: 'com.example.econexus.RunnerTests',
  );
}