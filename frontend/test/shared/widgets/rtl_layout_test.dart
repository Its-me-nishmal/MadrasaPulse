import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Directionality widget sets RTL correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: const Text('السلام عليكم'),
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
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: const Text('Hello'),
        ),
      ),
    );
    expect(
      Directionality.of(tester.element(find.text('Hello'))),
      TextDirection.ltr,
    );
  });
}
