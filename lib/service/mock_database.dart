import '../model/history_log_item.dart';
import '../model/medical_entry.dart';
import '../model/roshetta.dart';
import '../model/user.dart';

/// In-memory fake data. Replace with a real database later (the other
/// services are the only code that touches this class).
class MockDatabase {
  MockDatabase._() {
    _seed();
  }
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
  final Map<String, List<String>> reports = {};
  int nextRoshettaId = 100;

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
        date: DateTime(2026, 10, 12),
        doctorName: omar.displayName,
        type: 'Note',
        details: 'Blood pressure checked, normal.',
      ),
      MedicalEntry(
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
        hasPicture: true,
      ),
      Roshetta(
        id: 2,
        medicine: 'Metformin',
        doctorName: mona.displayName,
        description: 'Take one tablet after breakfast.',
        date: DateTime(2026, 9, 3),
        hasPicture: true,
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
    reports[sara.nationalId] = ['Lab result', 'X-ray'];

    entries[youssef.nationalId] = [
      MedicalEntry(
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
