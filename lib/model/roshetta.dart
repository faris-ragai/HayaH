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
}
