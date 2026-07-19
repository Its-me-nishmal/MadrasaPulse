import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/core/constants/app_colors.dart';
import 'package:madrasapulse_frontend/shared/widgets/status_badge.dart';

Widget createTestApp(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  testWidgets('displays the status label text', (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Present')));
    expect(find.text('Present'), findsOneWidget);
  });

  testWidgets('uses correct color for status "present"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Present')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.present.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "absent"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Absent')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.absent.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "late"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Late')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.late.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "paid"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Paid')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.success.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "unpaid"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Unpaid')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.error.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "overdue"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Overdue')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.error.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "partial_paid"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(const StatusBadge(status: 'Partially_Paid')),
    );
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.warning.withValues(alpha: 0.15));
  });

  testWidgets('uses correct color for status "excused"',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const StatusBadge(status: 'Excused')));
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, AppColors.warning.withValues(alpha: 0.15));
  });

  testWidgets('uses default color for unknown status',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(const StatusBadge(status: 'Unknown')),
    );
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(
      boxDecoration.color,
      AppColors.textSecondary.withValues(alpha: 0.15),
    );
  });
}
