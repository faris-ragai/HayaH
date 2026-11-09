class HistoryLogItem {
  const HistoryLogItem({
    required this.action,
    required this.doctorName,
    required this.date,
  });

  final String action; // "Added note", "Added roshetta"...
  final String doctorName;
  final DateTime date;
}
