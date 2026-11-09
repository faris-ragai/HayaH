import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../service/patient_service.dart';
import '../widgets/app_theme.dart';
import '../widgets/roshetta_tile.dart';
import '../widgets/screen_scaffold.dart';
import 'roshetta_detail_screen.dart';

class MyRoshettasScreen extends StatelessWidget {
  const MyRoshettasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = AuthService.instance.currentPatient;
    if (patient == null) return const SizedBox.shrink();
    final service = PatientService.instance;

    return ListenableBuilder(
      listenable: service,
      builder: (context, _) {
        final list = service.roshettas(patient.nationalId);
        return ScreenScaffold(
          title: 'My roshettas',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (list.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No roshettas yet.',
                      textAlign: TextAlign.center, style: AppText.sub),
                ),
              for (final r in list) ...[
                RoshettaTile(
                  roshetta: r,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RoshettaDetailScreen(roshetta: r)),
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
