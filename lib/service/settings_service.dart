import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/sync_status.dart';

/// Language choice and (fake) sync status.
/// The language is only stored for now: no translation yet.
class SettingsService extends ChangeNotifier {
  SettingsService._();
  static final SettingsService instance = SettingsService._();

  bool isArabic = true; // Arabic is the default in the design
  SyncStatus status = SyncStatus.synced;
  int pendingChanges = 3;
  DateTime lastSync = DateTime.now();

  static const _langKey = 'hayah_is_arabic';

  /// Call once before runApp.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    isArabic = prefs.getBool(_langKey) ?? true;
  }

  void setArabic(bool value) {
    isArabic = value;
    SharedPreferences.getInstance().then((p) => p.setBool(_langKey, value));
    notifyListeners();
  }

  void setStatus(SyncStatus value) {
    status = value;
    notifyListeners();
  }

  void refreshNow() {
    status = SyncStatus.synced;
    lastSync = DateTime.now();
    notifyListeners();
  }
}
