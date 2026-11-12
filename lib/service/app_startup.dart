import 'auth_service.dart';
import 'image_service.dart';
import 'mock_database.dart';
import 'settings_service.dart';

/// Loads the saved data before the app starts.
Future<void> initServices() async {
  await MockDatabase.instance.load(); // saved data (or demo data the first time)
  await SettingsService.instance.load();
  await ImageService.instance.load();
  AuthService.instance.restoreSession(); // stay logged in
}
