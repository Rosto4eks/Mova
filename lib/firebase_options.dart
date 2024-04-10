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
    apiKey: 'AIzaSyD25EKSXhiY4_vnqk_wNDhYzF-uqtqAQ8U',
    appId: '1:523608283316:web:787e228e5d9a42a24e1fe1',
    messagingSenderId: '523608283316',
    projectId: 'mova-a8d84',
    authDomain: 'mova-a8d84.firebaseapp.com',
    databaseURL: 'https://mova-a8d84-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'mova-a8d84.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9kHOrq8c_RlKBW0H3qQiZDx_4uCtEccw',
    appId: '1:523608283316:android:b695ef950c16ff464e1fe1',
    messagingSenderId: '523608283316',
    projectId: 'mova-a8d84',
    databaseURL: 'https://mova-a8d84-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'mova-a8d84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASDz5O83m9rR4KirknWuXcK9OTLc_SP0E',
    appId: '1:523608283316:ios:7a2285cf67de59b84e1fe1',
    messagingSenderId: '523608283316',
    projectId: 'mova-a8d84',
    databaseURL: 'https://mova-a8d84-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'mova-a8d84.appspot.com',
    iosBundleId: 'com.example.mova',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASDz5O83m9rR4KirknWuXcK9OTLc_SP0E',
    appId: '1:523608283316:ios:ceffa0ae375a3e014e1fe1',
    messagingSenderId: '523608283316',
    projectId: 'mova-a8d84',
    databaseURL: 'https://mova-a8d84-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'mova-a8d84.appspot.com',
    iosBundleId: 'com.example.mova.RunnerTests',
  );
}