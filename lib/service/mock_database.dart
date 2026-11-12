import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/history_log_item.dart';
import '../model/medical_entry.dart';
import '../model/report_item.dart';
import '../model/roshetta.dart';
import '../model/user.dart';
import 'mock_seed.dart';

/// Fake database. Data is kept in memory and saved on the device
/// (shared_preferences, as one JSON text), so it survives closing the app.
/// The other services are the only code that touches this class.
class MockDatabase {
  MockDatabase._();
  static final MockDatabase instance = MockDatabase._();

  final List<Patient> patients = [];
  final List<Doctor> doctors = [];

  /// national ID -> password
  final Map<String, String> passwords = {};

  /// patient ID -> IDs of doctors the patient allowed
  final Map<String, List<String>> allowed = {};
  final Map<String, List<MedicalEntry>> entries = {};
  final Map<String, List<Roshetta>> roshettas = {};
  final Map<String, List<HistoryLogItem>> logs = {};
  final Map<String, List<ReportItem>> reports = {};
  int nextRoshettaId = 100;
  int nextEntryId = 1;

  static const _dbKey = 'hayah_db_v1';
  static const _sessionKey = 'hayah_session_v1';
  SharedPreferences? _prefs;

  /// National ID of the user who was logged in last time (stay logged in).
  String? savedSessionId;

  /// Call once before runApp.
  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    savedSessionId = _prefs!.getString(_sessionKey);
    final raw = _prefs!.getString(_dbKey);
    if (raw == null) {
      seedDemoData(this);
      await save();
      return;
    }
    try {
      _fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Broken or old data: start again with the demo data.
      _clear();
      seedDemoData(this);
      await save();
    }
  }

  Future<void> save() async {
    await _prefs?.setString(_dbKey, jsonEncode(_toJson()));
  }

  Future<void> saveSession(String? id) async {
    savedSessionId = id;
    if (id == null) {
      await _prefs?.remove(_sessionKey);
    } else {
      await _prefs?.setString(_sessionKey, id);
    }
  }

  void _clear() {
    patients.clear();
    doctors.clear();
    passwords.clear();
    allowed.clear();
    entries.clear();
    roshettas.clear();
    logs.clear();
    reports.clear();
    nextRoshettaId = 100;
    nextEntryId = 1;
  }

  Map<String, dynamic> _toJson() => {
        'patients': patients.map((p) => p.toJson()).toList(),
        'doctors': doctors.map((d) => d.toJson()).toList(),
        'passwords': passwords,
        'allowed': allowed,
        'entries': entries.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
        'roshettas': roshettas.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
        'logs': logs.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
        'reports': reports.map((k, v) => MapEntry(k, v.map((e) => e.toJson()).toList())),
        'nextRoshettaId': nextRoshettaId,
        'nextEntryId': nextEntryId,
      };

  void _fromJson(Map<String, dynamic> j) {
    _clear();
    for (final p in j['patients'] as List) {
      patients.add(Patient.fromJson(p as Map<String, dynamic>));
    }
    for (final d in j['doctors'] as List) {
      doctors.add(Doctor.fromJson(d as Map<String, dynamic>));
    }
    passwords.addAll(Map<String, String>.from(j['passwords'] as Map));
    (j['allowed'] as Map).forEach((k, v) {
      allowed[k as String] = List<String>.from(v as List);
    });
    (j['entries'] as Map).forEach((k, v) {
      entries[k as String] = (v as List)
          .map((e) => MedicalEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    });
    (j['roshettas'] as Map).forEach((k, v) {
      roshettas[k as String] =
          (v as List).map((e) => Roshetta.fromJson(e as Map<String, dynamic>)).toList();
    });
    (j['logs'] as Map).forEach((k, v) {
      logs[k as String] = (v as List)
          .map((e) => HistoryLogItem.fromJson(e as Map<String, dynamic>))
          .toList();
    });
    (j['reports'] as Map).forEach((k, v) {
      reports[k as String] = (v as List).map((e) => ReportItem.fromJson(e)).toList();
    });
    nextRoshettaId = j['nextRoshettaId'] as int;
    nextEntryId = j['nextEntryId'] as int;
  }
}
