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

  Map<String, dynamic> toJson() => {'name': name, 'nationalId': nationalId};
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

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'allergies': allergies};

  factory Patient.fromJson(Map<String, dynamic> j) => Patient(
        name: j['name'] as String,
        nationalId: j['nationalId'] as String,
        allergies: (j['allergies'] as String?) ?? '',
      );
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
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'specialty': specialty,
        'licenseNumber': licenseNumber,
      };

  factory Doctor.fromJson(Map<String, dynamic> j) => Doctor(
        name: j['name'] as String,
        nationalId: j['nationalId'] as String,
        specialty: (j['specialty'] as String?) ?? '',
        licenseNumber: (j['licenseNumber'] as String?) ?? '',
      );

  @override
  String get displayName => name.startsWith('Dr.') ? name : 'Dr. $name';
}
