class Roshetta {
  const Roshetta({
    required this.id,
    required this.medicine,
    required this.doctorName,
    required this.description,
    required this.date,
    this.hasPicture = false,
  });

  final int id;
  final String medicine;
  final String doctorName;
  final String description;
  final DateTime date;
  final bool hasPicture;

  Map<String, dynamic> toJson() => {
        'id': id,
        'medicine': medicine,
        'doctorName': doctorName,
        'description': description,
        'date': date.toIso8601String(),
        'hasPicture': hasPicture,
      };

  factory Roshetta.fromJson(Map<String, dynamic> j) => Roshetta(
        id: j['id'] as int,
        medicine: j['medicine'] as String,
        doctorName: j['doctorName'] as String,
        description: j['description'] as String,
        date: DateTime.parse(j['date'] as String),
        hasPicture: (j['hasPicture'] as bool?) ?? false,
      );
}
