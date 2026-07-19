import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Directionality widget sets RTL correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('السلام عليكم'),
        ),
      ),
    );
    expect(
      Directionality.of(tester.element(find.text('السلام عليكم'))),
      TextDirection.rtl,
    );
  });

  testWidgets('Directionality widget sets LTR correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: Text('Hello'),
        ),
      ),
    );
    expect(
      Directionality.of(tester.element(find.text('Hello'))),
      TextDirection.ltr,
    );
  });
}
