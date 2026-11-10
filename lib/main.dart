import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/doctor_shell_screen.dart';
import 'screens/patient_shell_screen.dart';
import 'screens/welcome_screen.dart';
import 'service/auth_service.dart';
import 'service/mock_database.dart';
import 'service/settings_service.dart';
import 'widgets/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MockDatabase.instance.load(); // saved data (or demo data the first time)
  await SettingsService.instance.load();

  // Stay logged in: go straight to the home tabs if someone was logged in.
  final auth = AuthService.instance;
  auth.restoreSession();
  Widget home = const WelcomeScreen();
  if (auth.currentUser != null) {
    home = auth.isDoctor ? const DoctorShellScreen() : const PatientShellScreen();
  }
  runApp(MyApp(home: home));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.home = const WelcomeScreen()});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    // Rebuilds when the language changes: Arabic = right-to-left layout.
    return ListenableBuilder(
      listenable: SettingsService.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Doctor and Patient App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: Locale(SettingsService.instance.isArabic ? 'ar' : 'en'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: home,
        );
      },
    );
  }
}
