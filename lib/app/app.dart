import 'package:demo/views/calculator_view.dart';
import 'package:demo/views/home_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learn',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: HomeView(),
    );
  }
}

