import 'package:blibli_app/test/unknown_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("测试UnknownTestPage", (WidgetTester widgetTester) async {
    var app = MaterialApp(home: UnknownPage());
    await widgetTester.pumpWidget(app);
    expect(find.text("404"),findsOneWidget);
  });
}
