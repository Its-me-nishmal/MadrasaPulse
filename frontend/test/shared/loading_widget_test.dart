import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/shared/widgets/loading_widget.dart';

Widget createTestApp(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  testWidgets('renders CircularProgressIndicator', (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const LoadingWidget()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders message when provided', (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(const LoadingWidget(message: 'Loading...')),
    );
    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('does not render message when message is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const LoadingWidget()));
    expect(find.byType(Text), findsNothing);
  });

  testWidgets('wraps in Scaffold when fullScreen is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(const LoadingWidget(fullScreen: true)),
    );
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('does not wrap in Scaffold when fullScreen is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestApp(const LoadingWidget()));
    expect(find.byType(Scaffold), findsNothing);
  });
}
