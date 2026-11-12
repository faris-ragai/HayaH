import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../service/settings_service.dart';
import '../widgets/app_theme.dart';
import 'app_router.dart';

/// The app itself: theme, languages and the first screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          home: startScreen(),
        );
      },
    );
  }
}
