// @dart=2.9
import 'package:c_n_jokes/chuck.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_options/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: "AIzaSyAzNGC0Yct6vVSL7rBcsccRIKkcBv8xQ_Y",
    appId: "1:384767541305:android:00107131f7f4805e32cde8",
    messagingSenderId: "384767541305",
    projectId: "c-n-jokes",
  ),);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chucking Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChuckCardPage(),
    );
  }
}
