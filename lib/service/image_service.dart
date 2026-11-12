// ignore_for_file: unnecessary_import

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Picks pictures from the gallery / camera and keeps them on the device.
/// Pictures are shrunk (max 1024 px, quality 75) and saved as text in
/// shared_preferences, so it works on Android, iOS, web and desktop.
/// Other data only stores the picture id (see User.picture, Roshetta.pictureId).
class ImageService {
  ImageService._();
  static final ImageService instance = ImageService._();

  static const _prefix = 'hayah_img_';
  final Map<String, Uint8List> _cache = {};
  final ImagePicker _picker = ImagePicker();
  SharedPreferences? _prefs;

  /// Camera only on phones. Desktop and web use the gallery / file picker.
  bool get cameraAvailable =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Call once before runApp.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _prefs = prefs;
    for (final key in prefs.getKeys()) {
      if (!key.startsWith(_prefix)) continue;
      final raw = prefs.getString(key);
      if (raw == null) continue;
      try {
        _cache[key.substring(_prefix.length)] = base64Decode(raw);
      } catch (_) {
        // ignore a broken picture
      }
    }
  }

  Uint8List? bytes(String? id) => id == null ? null : _cache[id];

  /// Opens the gallery or camera. Returns the new picture id,
  /// or null when the user cancelled or something went wrong.
  Future<String?> pick(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 75,
      );
      if (file == null) return null;
      final data = await file.readAsBytes();
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      _cache[id] = data;
      await _prefs?.setString('$_prefix$id', base64Encode(data));
      return id;
    } catch (_) {
      return null;
    }
  }
}
