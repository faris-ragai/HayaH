import 'package:flutter/foundation.dart';
import '../model/date_format.dart';
import '../model/history_log_item.dart';
import '../model/medical_entry.dart';
import '../model/report_item.dart';
import '../model/roshetta.dart';
import '../model/user.dart';
import 'mock_database.dart';

/// Search, medical file, roshettas, history log, allowed doctors.
/// Everything is read/written in memory.
class PatientService extends ChangeNotifier {
  PatientService._();
  static final PatientService instance = PatientService._();

  final MockDatabase _db = MockDatabase.instance;

  // ---------- search ----------
  List<Patient> get allPatients => List.unmodifiable(_db.patients);

  List<Patient> get recentPatients => _db.patients.take(3).toList();

  List<Patient> search(String query, {required bool byId}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return List.of(_db.patients);
    return _db.patients.where((p) {
      return byId ? p.nationalId.contains(q) : p.name.toLowerCase().contains(q);
    }).toList();
  }

  // ---------- permissions ----------
  bool isAllowed(String patientId, String doctorId) =>
      (_db.allowed[patientId] ?? const <String>[]).contains(doctorId);

  List<Doctor> allowedDoctors(String patientId) {
    final ids = _db.allowed[patientId] ?? const <String>[];
    return _db.doctors.where((d) => ids.contains(d.nationalId)).toList();
  }

  List<Doctor> notAllowedDoctors(String patientId) {
    final ids = _db.allowed[patientId] ?? const <String>[];
    return _db.doctors.where((d) => !ids.contains(d.nationalId)).toList();
  }

  void allowDoctor(String patientId, String doctorId) {
    final list = _db.allowed.putIfAbsent(patientId, () => []);
    if (!list.contains(doctorId)) list.add(doctorId);
    _db.save();
    notifyListeners();
  }

  void removeDoctor(String patientId, String doctorId) {
    _db.allowed[patientId]?.remove(doctorId);
    _db.save();
    notifyListeners();
  }

  // ---------- medical file ----------
  List<MedicalEntry> entries(String patientId) {
    final list = List.of(_db.entries[patientId] ?? const <MedicalEntry>[]);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// Only a doctor calls this.
  void addEntry({
    required Patient patient,
    required Doctor doctor,
    required DateTime date,
    required String type,
    required String details,
  }) {
    _db.entries.putIfAbsent(patient.nationalId, () => []).add(MedicalEntry(
          id: _db.nextEntryId++,
          date: date,
          doctorName: doctor.displayName,
          type: type,
          details: details,
        ));
    _log(patient.nationalId, 'Added ${type.toLowerCase()}', doctor);
    _db.save();
    notifyListeners();
  }

  /// Doctor edits an old entry. The edit is written in the history log.
  void editEntry({
    required Patient patient,
    required Doctor doctor,
    required int entryId,
    required DateTime date,
    required String type,
    required String details,
  }) {
    final list = _db.entries[patient.nationalId];
    if (list == null) return;
    final i = list.indexWhere((e) => e.id == entryId);
    if (i < 0) return;
    list[i] = MedicalEntry(
      id: entryId,
      date: date,
      doctorName: doctor.displayName,
      type: type,
      details: details,
    );
    _log(patient.nationalId, 'Edited ${type.toLowerCase()}', doctor);
    _db.save();
    notifyListeners();
  }

  // ---------- roshettas ----------
  List<Roshetta> roshettas(String patientId) {
    final list = List.of(_db.roshettas[patientId] ?? const <Roshetta>[]);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  void addRoshetta({
    required Patient patient,
    required Doctor doctor,
    required String medicine,
    required String doctorName,
    required String description,
    String? pictureId,
  }) {
    _db.roshettas.putIfAbsent(patient.nationalId, () => []).add(Roshetta(
          id: _db.nextRoshettaId++,
          medicine: medicine,
          doctorName: doctorName,
          description: description,
          date: DateTime.now(),
          pictureId: pictureId,
        ));
    _log(patient.nationalId, 'Added roshetta', doctor);
    _db.save();
    notifyListeners();
  }

  /// Roshettas the doctor wrote today (shown on the doctor home screen).
  int roshettasTodayBy(Doctor doctor) {
    final today = DateTime.now();
    var count = 0;
    for (final list in _db.roshettas.values) {
      for (final r in list) {
        if (r.doctorName == doctor.displayName && isSameDay(r.date, today)) count++;
      }
    }
    return count;
  }

  // ---------- history log ----------
  List<HistoryLogItem> logs(String patientId) {
    final list = List.of(_db.logs[patientId] ?? const <HistoryLogItem>[]);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  void _log(String patientId, String action, Doctor doctor) {
    _db.logs.putIfAbsent(patientId, () => []).add(HistoryLogItem(
          action: action,
          doctorName: doctor.displayName,
          date: DateTime.now(),
        ));
  }

  // ---------- reports (lab results / X-rays) ----------
  List<ReportItem> reports(String patientId) =>
      List.unmodifiable(_db.reports[patientId] ?? const <ReportItem>[]);

  /// [label] is "Lab result" or "X-ray"; [imageId] comes from ImageService.
  void addReport(
    Patient patient,
    Doctor doctor, {
    required String label,
    String? imageId,
  }) {
    _db.reports
        .putIfAbsent(patient.nationalId, () => [])
        .add(ReportItem(label: label, imageId: imageId));
    _log(patient.nationalId, 'Uploaded ${label.toLowerCase()}', doctor);
    _db.save();
    notifyListeners();
  }
}
