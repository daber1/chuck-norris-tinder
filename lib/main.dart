// @dart=2.9
import 'package:c_n_jokes/chuck.dart';
import 'package:flutter/material.dart';

void main() {
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
