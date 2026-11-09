/// Base user. Patient and Doctor are built on top of it (inheritance).
class User {
  User({required this.name, required this.nationalId, this.picture});

  String name;
  final String nationalId; // = user ID
  String? picture;

  /// Name without a leading "Dr." (used for initials).
  String get bareName => name.replaceFirst(RegExp(r'^Dr\.\s*'), '').trim();

  String get displayName => name;

  String get firstName {
    final parts = bareName.split(RegExp(r'\s+'));
    return parts.isEmpty || parts.first.isEmpty ? name : parts.first;
  }

  String get initials {
    final parts = bareName.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  /// The QR code is generated from the national ID.
  String get qrData => nationalId;
}

class Patient extends User {
  Patient({
    required super.name,
    required super.nationalId,
    super.picture,
    this.allergies = '',
  });

  /// "Allergies and chronic diseases" box.
  String allergies;
}

class Doctor extends User {
  Doctor({
    required super.name,
    required super.nationalId,
    super.picture,
    required this.specialty,
    required this.licenseNumber,
  });

  String specialty;
  String licenseNumber;

  @override
  String get displayName => name.startsWith('Dr.') ? name : 'Dr. $name';
}
