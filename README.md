# Doctor & Patient App (UI only)

All 26 screens from "Doctor & Patient App - All Screens", connected with
navigation. No Firebase, no backend: data lives in memory (`service/mock_database.dart`).

## Run
```
flutter create doctor_patient_app      # makes android/ios/web folders
# copy lib/, test/ and pubspec.yaml from this project into it (replace)
cd doctor_patient_app
flutter pub get
flutter run
```

## Demo logins (password for all: 1234)
| Role    | National ID    | Notes                                   |
|---------|----------------|-----------------------------------------|
| Patient | 29901010101010 | Sara Ahmed, has file + roshettas        |
| Doctor  | 28801010101010 | Dr. Omar Hassan (allowed by Sara)       |
| Doctor  | 29005050505050 | Dr. Mona Adel                           |

Doctor tip: search "Sara" and open **Sara Mahmoud** to see the "No access" screen.
Scan QR has no camera: tap the camera box to simulate a scan.

## Folders
- `lib/model`   : User / Patient / Doctor (inheritance), MedicalEntry, Roshetta, HistoryLogItem, SyncStatus
- `lib/service` : mock_database, auth_service, patient_service, settings_service
- `lib/widgets` : theme, ScreenScaffold (green header), buttons, fields, cards, bottom nav, QR placeholder
- `lib/screens` : one file per screen + `app_router.dart` (goToHome, openPatient)

## Flow
Welcome -> Login -> (Create account -> New patient <-> New doctor)
- Patient tabs: Home | My file | Roshetta | Profile
  Home -> My QR, Roshetta detail, Allowed doctors, History log
  My file -> Reports, History log      Profile -> Settings -> Sync states
- Doctor tabs: Home | Search | Scan | Profile
  Search/Scan -> Patient file (or No access -> Basic profile)
  Patient file -> Add medical info, New roshetta, Reports, History log

## Not done on purpose
Real QR/camera, picture picker, translation (the language choice is stored only), real sync.
