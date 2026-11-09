import 'package:flutter/material.dart';
import '../model/sync_status.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../service/settings_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_theme.dart';
import '../widgets/info_card.dart';
import '../widgets/pill.dart';
import '../widgets/roshetta_tile.dart';
import '../widgets/screen_scaffold.dart';
import 'allowed_doctors_screen.dart';
import 'history_log_screen.dart';
import 'my_qr_screen.dart';
import 'roshetta_detail_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = AuthService.instance.currentPatient;
    if (patient == null) return const SizedBox.shrink();
    final service = PatientService.instance;
    final settings = SettingsService.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([service, settings, AuthService.instance]),
      builder: (context, _) {
        final roshettas = service.roshettas(patient.nationalId);
        final allowedCount = service.allowedDoctors(patient.nationalId).length;
        final logCount = service.logs(patient.nationalId).length;
        return ScreenScaffold(
          title: 'Hello, ${patient.firstName}',
          trailing: Pill(text: settings.status.label),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoCard(
                tint: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Allergies and chronic diseases', style: AppText.title),
                    const SizedBox(height: 5),
                    Text(patient.allergies.isEmpty ? 'None recorded' : patient.allergies,
                        style: AppText.value),
                  ],
                ),
              ),
              kGap,
              AppButton(
                label: 'Show my QR',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MyQrScreen()),
                ),
              ),
              if (roshettas.isNotEmpty) ...[
                kGap,
                const Text('Latest roshetta', style: AppText.label),
                const SizedBox(height: 6),
                RoshettaTile(
                  roshetta: roshettas.first,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RoshettaDetailScreen(roshetta: roshettas.first),
                    ),
                  ),
                ),
              ],
              kGap,
              InfoCard(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AllowedDoctorsScreen()),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Allowed doctors', style: AppText.title),
                    Pill(text: '$allowedCount doctors'),
                  ],
                ),
              ),
              kGap,
              InfoCard(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HistoryLogScreen(patient: patient),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('History log', style: AppText.title),
                    Pill(text: '$logCount entries'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
