class Roshetta {
  const Roshetta({
    required this.id,
    required this.medicine,
    required this.doctorName,
    required this.description,
    required this.date,
    this.pictureId,
  });

  final int id;
  final String medicine;
  final String doctorName;
  final String description;
  final DateTime date;

  /// Picture saved by ImageService (null = no picture).
  final String? pictureId;

  bool get hasPicture => pictureId != null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'medicine': medicine,
        'doctorName': doctorName,
        'description': description,
        'date': date.toIso8601String(),
        'pictureId': pictureId,
      };

  factory Roshetta.fromJson(Map<String, dynamic> j) => Roshetta(
        id: j['id'] as int,
        medicine: j['medicine'] as String,
        doctorName: j['doctorName'] as String,
        description: j['description'] as String,
        date: DateTime.parse(j['date'] as String),
        pictureId: j['pictureId'] as String?,
      );
}
