import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:madrasapulse_frontend/shared/widgets/status_badge.dart';

void main() {
  group('StatusBadge Widget', () {
    testWidgets('renders status text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StatusBadge(status: 'Present'))),
      );
      expect(find.text('Present'), findsOneWidget);
    });
  });
}
