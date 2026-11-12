// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/history_log_item.dart';
import '../model/medical_entry.dart';
import '../model/report_item.dart';
import '../model/roshetta.dart';
import '../model/user.dart';

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
      _seed();
      await save();
      return;
    }
    try {
      _fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Broken or old data: start again with the demo data.
      _clear();
      _seed();
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

  void _seed() {
    final omar = Doctor(
      name: 'Omar Hassan',
      nationalId: '28801010101010',
      specialty: 'Cardiology',
      licenseNumber: 'LIC-1001',
    );
    final mona = Doctor(
      name: 'Mona Adel',
      nationalId: '29005050505050',
      specialty: 'Internal medicine',
      licenseNumber: 'LIC-1002',
    );
    doctors.addAll([omar, mona]);

    final sara = Patient(
      name: 'Sara Ahmed',
      nationalId: '29901010101010',
      allergies: 'Penicillin allergy, Diabetes',
    );
    final saraM = Patient(
      name: 'Sara Mahmoud',
      nationalId: '30110101010101',
      allergies: 'None',
    );
    final youssef = Patient(
      name: 'Youssef Samir',
      nationalId: '29512121212121',
      allergies: 'Asthma',
    );
    final laila = Patient(
      name: 'Laila Nabil',
      nationalId: '30203030303030',
      allergies: 'None',
    );
    patients.addAll([sara, youssef, laila, saraM]);

    for (final u in [...doctors, ...patients]) {
      passwords[u.nationalId] = '1234';
      entries[u.nationalId] = [];
      roshettas[u.nationalId] = [];
      logs[u.nationalId] = [];
      reports[u.nationalId] = [];
      allowed[u.nationalId] = [];
    }

    allowed[sara.nationalId] = [omar.nationalId, mona.nationalId];
    allowed[youssef.nationalId] = [omar.nationalId];
    allowed[laila.nationalId] = [omar.nationalId];
    // Sara Mahmoud allowed nobody -> "No access" screen.

    entries[sara.nationalId] = [
      MedicalEntry(
        id: nextEntryId++,
        date: DateTime(2026, 10, 12),
        doctorName: omar.displayName,
        type: 'Note',
        details: 'Blood pressure checked, normal.',
      ),
      MedicalEntry(
        id: nextEntryId++,
        date: DateTime(2026, 9, 3),
        doctorName: mona.displayName,
        type: 'Test',
        details: 'Blood sugar test requested.',
      ),
    ];
    roshettas[sara.nationalId] = [
      Roshetta(
        id: 1,
        medicine: 'Amoxicillin',
        doctorName: omar.displayName,
        description: 'Take one capsule every 8 hours for 7 days.',
        date: DateTime(2026, 10, 12),
      ),
      Roshetta(
        id: 2,
        medicine: 'Metformin',
        doctorName: mona.displayName,
        description: 'Take one tablet after breakfast.',
        date: DateTime(2026, 9, 3),
      ),
      Roshetta(
        id: 3,
        medicine: 'Vitamin D',
        doctorName: omar.displayName,
        description: 'One capsule every day for 30 days.',
        date: DateTime(2026, 7, 20),
      ),
    ];
    logs[sara.nationalId] = [
      HistoryLogItem(action: 'Added note', doctorName: omar.displayName, date: DateTime(2026, 10, 12)),
      HistoryLogItem(action: 'Added roshetta', doctorName: omar.displayName, date: DateTime(2026, 10, 12)),
      HistoryLogItem(action: 'Edited allergies', doctorName: mona.displayName, date: DateTime(2026, 9, 3)),
      HistoryLogItem(action: 'Uploaded lab result', doctorName: mona.displayName, date: DateTime(2026, 9, 3)),
    ];
    reports[sara.nationalId] = [
      ReportItem(label: 'Lab result'),
      ReportItem(label: 'X-ray'),
    ];

    entries[youssef.nationalId] = [
      MedicalEntry(
        id: nextEntryId++,
        date: DateTime(2026, 8, 15),
        doctorName: omar.displayName,
        type: 'Note',
        details: 'Routine check-up.',
      ),
    ];
    logs[youssef.nationalId] = [
      HistoryLogItem(action: 'Added note', doctorName: omar.displayName, date: DateTime(2026, 8, 15)),
    ];
  }
}
