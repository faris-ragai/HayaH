import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_patient_app/main.dart';

void main() {
  testWidgets('App starts on the welcome screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Doctor and Patient App'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
