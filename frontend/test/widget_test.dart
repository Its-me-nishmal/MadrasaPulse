import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madrasapulse_frontend/main.dart';
import 'package:madrasapulse_frontend/shared/widgets/connectivity_listener.dart';

Future<bool> _alwaysOnline() async => true;

void main() {
  testWidgets('MadrasaPulseApp renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          connectivityCheckerProvider.overrideWithValue(_alwaysOnline),
        ],
        child: const MadrasaPulseApp(),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
