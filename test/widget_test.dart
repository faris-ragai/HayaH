import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_patient_app/main.dart';
import 'package:doctor_patient_app/service/settings_service.dart';

void main() {
  testWidgets('Welcome screen shows in English and Arabic', (tester) async {
    SettingsService.instance.isArabic = false;
    await tester.pumpWidget(const MyApp());
    expect(find.text('Doctor and Patient App'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    SettingsService.instance.setArabic(true);
    await tester.pumpAndSettle();
    expect(find.text('تطبيق الطبيب والمريض'), findsOneWidget);
    expect(find.text('متابعة'), findsOneWidget);
  });
}
