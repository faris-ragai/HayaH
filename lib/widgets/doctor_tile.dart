import 'package:flutter/material.dart';
import '../model/user.dart';
import 'app_theme.dart';
import 'info_card.dart';

/// Doctor name + specialty, with an optional widget at the end.
class DoctorTile extends StatelessWidget {
  const DoctorTile({super.key, required this.doctor, this.trailing, this.onTap});

  final Doctor doctor;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor.displayName, style: AppText.title),
                const SizedBox(height: 3),
                Text(doctor.specialty, style: AppText.sub),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
