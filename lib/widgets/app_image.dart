import 'package:flutter/material.dart';
import '../service/image_service.dart';
import 'pic_box.dart';

/// Shows a saved picture, or the green placeholder when there is none.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageId,
    required this.placeholder,
    this.width,
    this.height,
    this.radius = 12,
  });

  final String? imageId;
  final String placeholder;
  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final bytes = ImageService.instance.bytes(imageId);
    if (bytes == null) {
      return PicBox(label: placeholder, width: width, height: height, radius: radius);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.memory(
        bytes,
        width: width,
        height: height,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      ),
    );
  }
}

/// Full-screen viewer with pinch zoom.
void showImageViewer(BuildContext context, String? imageId, String placeholder) {
  final bytes = ImageService.instance.bytes(imageId);
  showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: bytes == null
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: PicBox(label: placeholder, radius: 0),
                    )
                  : Image.memory(bytes, fit: BoxFit.contain),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
