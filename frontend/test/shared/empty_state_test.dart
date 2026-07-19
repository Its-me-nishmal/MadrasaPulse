import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/shared/widgets/empty_state.dart';

Widget createTestApp(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  const testIcon = Icons.inbox;

  testWidgets('displays icon, title, and subtitle',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const EmptyState(
          icon: testIcon,
          title: 'No data',
          subtitle: 'There is nothing to show yet.',
        ),
      ),
    );
    expect(find.byIcon(testIcon), findsOneWidget);
    expect(find.text('No data'), findsOneWidget);
    expect(find.text('There is nothing to show yet.'), findsOneWidget);
  });

  testWidgets('shows action button when actionLabel and onAction are provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        EmptyState(
          icon: testIcon,
          title: 'No data',
          actionLabel: 'Add',
          onAction: () {},
        ),
      ),
    );
    expect(find.text('Add'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('does not show action button when actionLabel is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        const EmptyState(
          icon: testIcon,
          title: 'No data',
        ),
      ),
    );
    expect(find.byType(ElevatedButton), findsNothing);
  });

  testWidgets('tapping action button calls onAction callback',
      (WidgetTester tester) async {
    bool actionCalled = false;
    await tester.pumpWidget(
      createTestApp(
        EmptyState(
          icon: testIcon,
          title: 'No data',
          actionLabel: 'Add',
          onAction: () => actionCalled = true,
        ),
      ),
    );
    await tester.tap(find.text('Add'));
    expect(actionCalled, isTrue);
  });
}
