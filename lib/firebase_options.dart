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
        return windows;
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
    apiKey: 'AIzaSyBcbpode3E-CSk1f72pTcmP2zQ2bTzoSyw',
    appId: '1:823022469154:web:fe589550b9c11bc72a4a7b',
    messagingSenderId: '823022469154',
    projectId: 'recipes-fe238',
    authDomain: 'recipes-fe238.firebaseapp.com',
    databaseURL: 'https://recipes-fe238-default-rtdb.firebaseio.com',
    storageBucket: 'recipes-fe238.firebasestorage.app',
    measurementId: 'G-KSLFYNKYLV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtLGyBd1GYtdxDo7I8LH1kAywUJXyCkIM',
    appId: '1:823022469154:android:b7e0c6af361d74212a4a7b',
    messagingSenderId: '823022469154',
    projectId: 'recipes-fe238',
    databaseURL: 'https://recipes-fe238-default-rtdb.firebaseio.com',
    storageBucket: 'recipes-fe238.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVUHx7-JV6tc7GHEPWTmBl3oDklKfLoyc',
    appId: '1:823022469154:ios:df3fd0605c799b522a4a7b',
    messagingSenderId: '823022469154',
    projectId: 'recipes-fe238',
    databaseURL: 'https://recipes-fe238-default-rtdb.firebaseio.com',
    storageBucket: 'recipes-fe238.firebasestorage.app',
    iosBundleId: 'com.example.app2Mobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVUHx7-JV6tc7GHEPWTmBl3oDklKfLoyc',
    appId: '1:823022469154:ios:df3fd0605c799b522a4a7b',
    messagingSenderId: '823022469154',
    projectId: 'recipes-fe238',
    databaseURL: 'https://recipes-fe238-default-rtdb.firebaseio.com',
    storageBucket: 'recipes-fe238.firebasestorage.app',
    iosBundleId: 'com.example.app2Mobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBcbpode3E-CSk1f72pTcmP2zQ2bTzoSyw',
    appId: '1:823022469154:web:60a14ef192663ea12a4a7b',
    messagingSenderId: '823022469154',
    projectId: 'recipes-fe238',
    authDomain: 'recipes-fe238.firebaseapp.com',
    databaseURL: 'https://recipes-fe238-default-rtdb.firebaseio.com',
    storageBucket: 'recipes-fe238.firebasestorage.app',
    measurementId: 'G-MGE6T6LMB3',
  );

}