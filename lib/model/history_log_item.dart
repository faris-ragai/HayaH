class HistoryLogItem {
  const HistoryLogItem({
    required this.action,
    required this.doctorName,
    required this.date,
  });

  final String action; // "Added note", "Added roshetta"...
  final String doctorName;
  final DateTime date;

  Map<String, dynamic> toJson() => {
        'action': action,
        'doctorName': doctorName,
        'date': date.toIso8601String(),
      };

  factory HistoryLogItem.fromJson(Map<String, dynamic> j) => HistoryLogItem(
        action: j['action'] as String,
        doctorName: j['doctorName'] as String,
        date: DateTime.parse(j['date'] as String),
      );
}
