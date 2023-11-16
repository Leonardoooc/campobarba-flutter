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
    apiKey: 'AIzaSyA27UbgP410lRN_AYzE64XRypxFTrsztcA',
    appId: '1:483538825357:web:70841612a0675e368cb2c4',
    messagingSenderId: '483538825357',
    projectId: 'tickets-171e6',
    authDomain: 'tickets-171e6.firebaseapp.com',
    storageBucket: 'tickets-171e6.appspot.com',
    measurementId: 'G-6SYTJTVDFP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDd5oBu1a0goO1tLmsXnvBjM7VRIfTn_Nw',
    appId: '1:483538825357:android:d26625cad7ca90ef8cb2c4',
    messagingSenderId: '483538825357',
    projectId: 'tickets-171e6',
    storageBucket: 'tickets-171e6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrFjh7RPfDEwj_Qhm3XdUXt_S725pl948',
    appId: '1:483538825357:ios:f605a596c11b7f858cb2c4',
    messagingSenderId: '483538825357',
    projectId: 'tickets-171e6',
    storageBucket: 'tickets-171e6.appspot.com',
    iosBundleId: 'com.example.campobarba',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrFjh7RPfDEwj_Qhm3XdUXt_S725pl948',
    appId: '1:483538825357:ios:fc910cda967d50978cb2c4',
    messagingSenderId: '483538825357',
    projectId: 'tickets-171e6',
    storageBucket: 'tickets-171e6.appspot.com',
    iosBundleId: 'com.example.campobarba.RunnerTests',
  );
}