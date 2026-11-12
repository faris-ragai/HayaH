import 'package:flutter/material.dart';
import '../service/image_service.dart';
import 'app_theme.dart';

/// Round picture; shows the initials when there is no picture.
class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key, required this.initials, this.size = 66, this.imageId});

  final String initials;
  final double size;
  final String? imageId;

  @override
  Widget build(BuildContext context) {
    final bytes = ImageService.instance.bytes(imageId);
    if (bytes != null) {
      return ClipOval(
        child: Image.memory(bytes, width: size, height: size, fit: BoxFit.cover),
      );
    }
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.tint, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          color: AppColors.green,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.32,
        ),
      ),
    );
  }
}
