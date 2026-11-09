const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _two(int n) => n.toString().padLeft(2, '0');

/// 12 Oct 2026
String formatDate(DateTime d) => '${_two(d.day)} ${_months[d.month - 1]} ${d.year}';

/// 12 Oct 2026, 14:05
String formatDateTime(DateTime d) => '${formatDate(d)}, ${_two(d.hour)}:${_two(d.minute)}';

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
