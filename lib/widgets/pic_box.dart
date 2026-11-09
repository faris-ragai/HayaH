import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Light green placeholder where a picture / image would go.
class PicBox extends StatelessWidget {
  const PicBox({super.key, required this.label, this.width, this.height, this.radius = 12});

  final String label;
  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.tint,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.green)),
    );
  }
}
