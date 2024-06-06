import 'package:demo/views/calculator_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: CalculatorView(),
      ),
    );
  }
}
