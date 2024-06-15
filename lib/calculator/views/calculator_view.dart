import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// The main CalculatorView widget which is a StatefulWidget
class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  // Variables to hold the two input numbers and the result
  int x = 0;
  int y = 0;
  num z = 0;

  // Controllers to manage the input text fields
  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();

  late final AppLifecycleListener _listener;

  @override
  void initState() {
    // Initialize the text fields with default values
    super.initState();
    displayOneController.text = x.toString();
    displayTwoController.text = y.toString();

    _listener = AppLifecycleListener(
      onShow: _onShow,
      onHide: _onHide,
      onResume: _onResume,
      onDetach: _onDetach,
      onInactive: _onInactive,
      onPause: _onPause,
      onRestart: _onRestart,
      onStateChange: _onStateChanged,
      // onExitRequested: _onExitRequested,
    );
  }

  void _onShow() => print("onShow called");

  void _onHide() => print("onHide called");

  void _onResume() => print("onResume called");

  void _onDetach() => print("onDetach called");

  void _onInactive() => print("onInactive called");

  void _onPause() => print("onPause called");

  void _onRestart() => print("onRestart called");

  void _onStateChanged(AppLifecycleState state) {
    print("onStateChanged called with state: $state");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    displayOneController.dispose();
    displayTwoController.dispose();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          // First input field
          Display(
              key: const Key("displayOne"),
              hint: "Enter First Number", controller: displayOneController),
          const SizedBox(
            height: 30,
          ),
          // Second input field
          Display(
              key: const Key("displayTwo"),
              hint: "Enter Second Number", controller: displayTwoController),
          const SizedBox(
            height: 30,
          ),

          // Display the result
          Text(
            key: const Key("Result"),
            z.toString(),
            style: const TextStyle(fontSize: 40),
          ),
          const Spacer(),
          // Row of buttons for different operations
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Button for addition
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    // Perform addition and update the result
                    z = num.tryParse(displayOneController.text)! +
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.add),
              ),
              // Button for subtraction
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    // Perform subtraction and update the result
                    z = num.tryParse(displayOneController.text)! -
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.minus),
              ),
              // Button for multiplicaton
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    // Perform multiplication and update the result
                    z = num.tryParse(displayOneController.text)! *
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.multiply),
              ),
              // Button for division
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    // Perform division and update the result
                    z = num.tryParse(displayOneController.text)! /
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.divide),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // Button to clear the inputs and reset the result
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                x = 0;
                y = 0;
                z = 0;

                // Clear the text fields
                displayOneController.clear();
                displayTwoController.clear();
              });
            },
            label: const Text("Clear"),
          ),
        ],
      ),
    );
  }
}

// Widget for displaying a single input field
class Display extends StatelessWidget {
  const Display(
      {Key? key, this.hint = "Enter a number", required this.controller})
      : super(key: key);
  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black)),
    );
  }
}
