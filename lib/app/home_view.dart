import 'package:demo/app/container.dart';
import 'package:demo/calculator/views/calculator_view.dart';
import 'package:demo/icecream/views/icecream_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: IceCreamView(),
      ),
    );
  }
}
