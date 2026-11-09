import 'package:flutter/foundation.dart';
import '../model/user.dart';
import 'mock_database.dart';

/// Fake login / register. No server, no Firebase.
/// Demo accounts: see README (all passwords are 1234).
class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  final MockDatabase _db = MockDatabase.instance;
  User? currentUser;

  bool get isDoctor => currentUser is Doctor;

  Patient? get currentPatient {
    final u = currentUser;
    return u is Patient ? u : null;
  }

  Doctor? get currentDoctor {
    final u = currentUser;
    return u is Doctor ? u : null;
  }

  User? _find(String id) {
    for (final u in [..._db.doctors, ..._db.patients]) {
      if (u.nationalId == id) return u;
    }
    return null;
  }

  /// Returns an error message, or null when login worked.
  String? login(String id, String password) {
    final user = _find(id.trim());
    if (user == null || _db.passwords[user.nationalId] != password) {
      return 'Wrong National ID or password';
    }
    currentUser = user;
    notifyListeners();
    return null;
  }

  String? _validate(String name, String id, String password) {
    if (name.trim().isEmpty) return 'Enter your full name';
    if (!RegExp(r'^\d{14}$').hasMatch(id.trim())) {
      return 'National ID must be 14 digits';
    }
    if (password.isEmpty) return 'Enter a password';
    if (_find(id.trim()) != null) return 'This ID already has an account';
    return null;
  }

  void _initRecords(String id, String password) {
    _db.passwords[id] = password;
    _db.entries[id] = [];
    _db.roshettas[id] = [];
    _db.logs[id] = [];
    _db.reports[id] = [];
    _db.allowed[id] = [];
  }

  String? registerPatient({
    required String name,
    required String id,
    required String password,
  }) {
    final error = _validate(name, id, password);
    if (error != null) return error;
    final patient = Patient(name: name.trim(), nationalId: id.trim());
    _db.patients.add(patient);
    _initRecords(patient.nationalId, password);
    currentUser = patient;
    notifyListeners();
    return null;
  }

  String? registerDoctor({
    required String name,
    required String id,
    required String specialty,
    required String licenseNumber,
    required String password,
  }) {
    final error = _validate(name, id, password);
    if (error != null) return error;
    if (specialty.trim().isEmpty || licenseNumber.trim().isEmpty) {
      return 'Enter your specialty and license number';
    }
    final doctor = Doctor(
      name: name.trim(),
      nationalId: id.trim(),
      specialty: specialty.trim(),
      licenseNumber: licenseNumber.trim(),
    );
    _db.doctors.add(doctor);
    _initRecords(doctor.nationalId, password);
    currentUser = doctor;
    notifyListeners();
    return null;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }

  /// A user can only change their own name.
  void updateName(String name) {
    final u = currentUser;
    if (u == null || name.trim().isEmpty) return;
    u.name = name.trim();
    notifyListeners();
  }

  void updateDoctor({String? name, String? specialty, String? licenseNumber}) {
    final d = currentDoctor;
    if (d == null) return;
    if (name != null && name.trim().isNotEmpty) d.name = name.trim();
    if (specialty != null) d.specialty = specialty.trim();
    if (licenseNumber != null) d.licenseNumber = licenseNumber.trim();
    notifyListeners();
  }
}
