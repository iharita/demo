import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.green,
        child: const Center(child: Text("Hello World!", style: TextStyle(color: Colors.white, fontSize: 20),)),
      ),
    );
  }
}
