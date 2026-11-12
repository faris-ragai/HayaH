// ignore_for_file: prefer_const_constructors

import '../model/history_log_item.dart';
import '../model/medical_entry.dart';
import '../model/report_item.dart';
import '../model/roshetta.dart';
import '../model/user.dart';
import 'mock_database.dart';

/// Demo data used the first time the app runs.
void seedDemoData(MockDatabase db) {
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
  db.doctors.addAll([omar, mona]);

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
  db.patients.addAll([sara, youssef, laila, saraM]);

  for (final u in [...db.doctors, ...db.patients]) {
    db.passwords[u.nationalId] = '1234';
    db.entries[u.nationalId] = [];
    db.roshettas[u.nationalId] = [];
    db.logs[u.nationalId] = [];
    db.reports[u.nationalId] = [];
    db.allowed[u.nationalId] = [];
  }

  db.allowed[sara.nationalId] = [omar.nationalId, mona.nationalId];
  db.allowed[youssef.nationalId] = [omar.nationalId];
  db.allowed[laila.nationalId] = [omar.nationalId];
  // Sara Mahmoud db.allowed nobody -> "No access" screen.

  db.entries[sara.nationalId] = [
    MedicalEntry(
      id: db.nextEntryId++,
      date: DateTime(2026, 10, 12),
      doctorName: omar.displayName,
      type: 'Note',
      details: 'Blood pressure checked, normal.',
    ),
    MedicalEntry(
      id: db.nextEntryId++,
      date: DateTime(2026, 9, 3),
      doctorName: mona.displayName,
      type: 'Test',
      details: 'Blood sugar test requested.',
    ),
  ];
  db.roshettas[sara.nationalId] = [
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
  db.logs[sara.nationalId] = [
    HistoryLogItem(action: 'Added note', doctorName: omar.displayName, date: DateTime(2026, 10, 12)),
    HistoryLogItem(action: 'Added roshetta', doctorName: omar.displayName, date: DateTime(2026, 10, 12)),
    HistoryLogItem(action: 'Edited allergies', doctorName: mona.displayName, date: DateTime(2026, 9, 3)),
    HistoryLogItem(action: 'Uploaded lab result', doctorName: mona.displayName, date: DateTime(2026, 9, 3)),
  ];
  db.reports[sara.nationalId] = [
    ReportItem(label: 'Lab result'),
    ReportItem(label: 'X-ray'),
  ];

  db.entries[youssef.nationalId] = [
    MedicalEntry(
      id: db.nextEntryId++,
      date: DateTime(2026, 8, 15),
      doctorName: omar.displayName,
      type: 'Note',
      details: 'Routine check-up.',
    ),
  ];
  db.logs[youssef.nationalId] = [
    HistoryLogItem(action: 'Added note', doctorName: omar.displayName, date: DateTime(2026, 8, 15)),
  ];
}
