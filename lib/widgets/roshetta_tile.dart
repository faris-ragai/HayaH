// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/date_format.dart';
import '../model/roshetta.dart';
import 'app_theme.dart';
import 'info_card.dart';
import 'pic_box.dart';

class RoshettaTile extends StatelessWidget {
  const RoshettaTile({super.key, required this.roshetta, this.onTap});

  final Roshetta roshetta;
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
                Text(roshetta.medicine, style: AppText.title),
                SizedBox(height: 3),
                Text('${roshetta.doctorName}, ${formatDate(roshetta.date, ar: context.isAr)}',
                    style: AppText.sub),
              ],
            ),
          ),
          PicBox(label: context.tr('Pic'), width: 46, height: 46),
        ],
      ),
    );
  }
}
