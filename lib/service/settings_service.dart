import 'package:flutter/foundation.dart';
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

  void setArabic(bool value) {
    isArabic = value;
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
