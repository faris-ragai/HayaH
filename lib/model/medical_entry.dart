class MedicalEntry {
  const MedicalEntry({
    required this.id,
    required this.date,
    required this.doctorName,
    required this.type,
    required this.details,
  });

  final int id;
  final DateTime date;
  final String doctorName;
  final String type; // Note, Diagnosis, Test...
  final String details;

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'doctorName': doctorName,
        'type': type,
        'details': details,
      };

  factory MedicalEntry.fromJson(Map<String, dynamic> j) => MedicalEntry(
        id: j['id'] as int,
        date: DateTime.parse(j['date'] as String),
        doctorName: j['doctorName'] as String,
        type: j['type'] as String,
        details: j['details'] as String,
      );
}
