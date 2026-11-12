/// One lab result or X-ray in a patient's reports.
class ReportItem {
  const ReportItem({required this.label, this.imageId});

  final String label; // "Lab result" or "X-ray"
  final String? imageId; // picture saved by ImageService

  Map<String, dynamic> toJson() => {'label': label, 'imageId': imageId};

  /// Also reads the old format, where a report was just a text label.
  factory ReportItem.fromJson(Object? j) {
    if (j is String) return ReportItem(label: j);
    final m = j as Map<String, dynamic>;
    return ReportItem(label: m['label'] as String, imageId: m['imageId'] as String?);
  }
}
