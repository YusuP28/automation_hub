// Basic widget test for Automation Hub mobile app.

import 'package:flutter_test/flutter_test.dart';

import 'package:automation_mobile/main.dart';

void main() {
  testWidgets('Automation Hub app renders core UI', (WidgetTester tester) async {
    await tester.pumpWidget(const AutomationHub());
    await tester.pump();

    expect(find.text('Automation Hub'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);
  });
}
