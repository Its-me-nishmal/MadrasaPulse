import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madrasapulse_frontend/main.dart';

void main() {
  testWidgets('App renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MadrasaPulseApp()));
    expect(find.text('MadrasaPulse'), findsOneWidget);
  });
}
