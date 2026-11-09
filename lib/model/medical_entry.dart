class MedicalEntry {
  const MedicalEntry({
    required this.date,
    required this.doctorName,
    required this.type,
    required this.details,
  });

  final DateTime date;
  final String doctorName;
  final String type; // Note, Diagnosis, Test...
  final String details;
}
