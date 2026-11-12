// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import 'app_button.dart';
import 'app_theme.dart';
import 'avatar_circle.dart';

/// Big avatar with a "Change picture" button (patient and doctor profile).
class ProfilePictureBlock extends StatelessWidget {
  const ProfilePictureBlock({
    super.key,
    required this.initials,
    required this.imageId,
    required this.onChange,
  });

  final String initials;
  final String? imageId;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: AvatarCircle(initials: initials, imageId: imageId)),
        kGap,
        AppButton(label: context.tr('Change picture'), primary: false, onPressed: onChange),
      ],
    );
  }
}
