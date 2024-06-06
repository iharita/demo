import 'package:demo/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Main function to run the test.
  group("Calculator View Test ", () {
  testWidgets("Calculator Basic Test", (WidgetTester tester) async{
    // Define a test case with a description "Hello World Test".

    await tester.pumpWidget(MyApp());
    // Build (or "pump") the MyApp widget into the widget tree.

    expect(find.byKey(Key("Result")), findsOneWidget);
    expect(find.byKey(Key("displayOne")), findsOneWidget);
    expect(find.byKey(Key("displayTwo")), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.add), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.minus), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.multiply), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.divide), findsOneWidget);
    // Check if exactly one widget of type Container is found in the widget tree
  });

  testWidgets("Operation Test", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.enterText(find.byKey(Key("displayOne")), "20");
    await tester.enterText(find.byKey(Key("displayTwo")), "10");

    await tester.tap(find.byIcon(CupertinoIcons.add));
    await tester.pump();

    expect(find.text("30"), findsOneWidget);

    await tester.tap(find.byIcon(CupertinoIcons.minus));
    await tester.pump();

    expect(find.text("10"), findsNWidgets(2));

    await tester.tap(find.byIcon(CupertinoIcons.multiply));
    await tester.pump();

    expect(find.text("200"), findsOneWidget);

    await tester.tap(find.byIcon(CupertinoIcons.divide));
    await tester.pump();

    expect(find.text("2.0"), findsOneWidget);
  });
  });
}