// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/localization_service.dart';
import '../model/date_format.dart';
import '../model/user.dart';
import '../service/patient_service.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/screen_scaffold.dart';

/// Every edit with the doctor name and date, so nothing changes silently.
class HistoryLogScreen extends StatelessWidget {
  const HistoryLogScreen({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final service = PatientService.instance;
    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final items = service.logs(patient.nationalId);
        return ScreenScaffold(
          title: context.tr('History log'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (items.isEmpty)
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(context.tr('Nothing here yet.'),
                      textAlign: TextAlign.center, style: AppText.sub),
                ),
              for (final item in items) ...[
                InfoCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.tr(item.action), style: AppText.title),
                          Text(formatDate(item.date, ar: context.isAr), style: AppText.sub),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(item.doctorName, style: AppText.sub),
                    ],
                  ),
                ),
                kGap,
              ],
            ],
          ),
        );
      },
    );
  }
}
