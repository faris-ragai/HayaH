import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../service/image_service.dart';
import '../service/localization_service.dart';
import 'app_theme.dart';

/// Asks "camera or gallery" (phones) and returns the new picture id.
/// On web / desktop it opens the gallery directly. Returns null if cancelled.
Future<String?> pickImageWithSheet(BuildContext context) async {
  final service = ImageService.instance;
  ImageSource? source = ImageSource.gallery;
  if (service.cameraAvailable) {
    source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.bg,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined, color: AppColors.green),
              title: Text(context.tr('Take a photo')),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: AppColors.green),
              title: Text(context.tr('Choose from gallery')),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
  if (source == null) return null;
  return service.pick(source);
}
