// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAYIwo5mn8gj_FgUO3ApAgwebdd7KvuR4w',
    appId: '1:871125783880:web:f06d1890c3a47043c10f7d',
    messagingSenderId: '871125783880',
    projectId: 'vue-chat-9380b',
    authDomain: 'vue-chat-9380b.firebaseapp.com',
    databaseURL: 'https://vue-chat-9380b-default-rtdb.firebaseio.com',
    storageBucket: 'vue-chat-9380b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzJrhUDm-Y_ncbcsbvRkUp6fE1lRqFniQ',
    appId: '1:871125783880:android:b2981bb3b56c2dbcc10f7d',
    messagingSenderId: '871125783880',
    projectId: 'vue-chat-9380b',
    databaseURL: 'https://vue-chat-9380b-default-rtdb.firebaseio.com',
    storageBucket: 'vue-chat-9380b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB39V1NplIPigvWU3SlazY3dQX2AXmD9CY',
    appId: '1:871125783880:ios:f5ef274832d95c97c10f7d',
    messagingSenderId: '871125783880',
    projectId: 'vue-chat-9380b',
    databaseURL: 'https://vue-chat-9380b-default-rtdb.firebaseio.com',
    storageBucket: 'vue-chat-9380b.firebasestorage.app',
    iosBundleId: 'note.ouammou.noteapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB39V1NplIPigvWU3SlazY3dQX2AXmD9CY',
    appId: '1:871125783880:ios:f5ef274832d95c97c10f7d',
    messagingSenderId: '871125783880',
    projectId: 'vue-chat-9380b',
    databaseURL: 'https://vue-chat-9380b-default-rtdb.firebaseio.com',
    storageBucket: 'vue-chat-9380b.firebasestorage.app',
    iosBundleId: 'note.ouammou.noteapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDjwbLX5z9BklfsE6J6PZutSnSGM-goYkY',
    appId: '1:871125783880:web:b53448cf26a60910c10f7d',
    messagingSenderId: '871125783880',
    projectId: 'vue-chat-9380b',
    authDomain: 'vue-chat-9380b.firebaseapp.com',
    databaseURL: 'https://vue-chat-9380b-default-rtdb.firebaseio.com',
    storageBucket: 'vue-chat-9380b.firebasestorage.app',
  );
}
