import 'package:flutter_test/flutter_test.dart';
import 'package:motivamate/main.dart';

void main() {
  testWidgets('MotivaMate app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MotivaMateApp());

    // Verify that the app starts with authentication screen
    expect(find.text('MotivaMate'), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Sign In'), findsWidgets);
  });

  testWidgets('Quote rotation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MotivaMateApp());
    
    // The quotes should be present in the app
    // This test would need to be more specific once authentication is bypassed
    // for testing purposes
  });

  testWidgets('Space background renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MotivaMateApp());
    
    // Space background should be rendered
    // This is a basic smoke test to ensure the app doesn't crash
    await tester.pump();
  });
}