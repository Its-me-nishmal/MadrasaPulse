import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/shared/widgets/error_widget.dart';

Widget createTestApp(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  testWidgets('displays error message', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const AppErrorWidget(message: 'Something went wrong'),
      ),
    );
    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('displays title when provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const AppErrorWidget(
          message: 'Something went wrong',
          title: 'Error',
        ),
      ),
    );
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('shows Retry button when onRetry is provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        AppErrorWidget(
          message: 'Something went wrong',
          onRetry: () {},
        ),
      ),
    );
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('does not show Retry button when onRetry is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const AppErrorWidget(message: 'Something went wrong'),
      ),
    );
    expect(find.text('Retry'), findsNothing);
  });

  testWidgets('tapping Retry calls the onRetry callback',
      (WidgetTester tester) async {
    bool retryCalled = false;
    await tester.pumpWidget(
      createTestApp(
        AppErrorWidget(
          message: 'Something went wrong',
          onRetry: () => retryCalled = true,
        ),
      ),
    );
    await tester.tap(find.text('Retry'));
    expect(retryCalled, isTrue);
  });
}
