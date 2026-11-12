// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/localization_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/row_card.dart';
import '../widgets/screen_scaffold.dart';
import 'app_router.dart';
import 'scan_qr_screen.dart';
import 'search_screen.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = AuthService.instance.currentDoctor;
    if (doctor == null) return SizedBox.shrink();
    final service = PatientService.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([service, AuthService.instance]),
      builder: (context, _) {
        return ScreenScaffold(
          title: context.tr('Dr. {name}', {'name': doctor.firstName}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: context.tr('Search patient'),
                hint: context.tr('National ID or name'),
                onSubmitted: (text) => pushScreen(context, SearchScreen(initialQuery: text)),
              ),
              kGap,
              AppButton(
                label: context.tr('Scan patient QR'),
                onPressed: () => pushScreen(context, ScanQrScreen()),
              ),
              kGap,
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.tr('Recent patients'), style: AppText.title),
                    SizedBox(height: 4),
                    for (final p in service.recentPatients)
                      InkWell(
                        onTap: () => openPatient(context, p),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(p.name, style: AppText.sub.copyWith(fontSize: 12.5)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              kGap,
              RowCard(
                title: context.tr('My roshettas today'),
                trailing: Pill(text: '${service.roshettasTodayBy(doctor)}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
