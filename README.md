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

## Languages
Arabic (right-to-left, default) and English. All screen texts are in `lib/service/localization_service.dart`: use `context.tr('English text')`. Switch from the Welcome screen or Settings.

## Pictures
Real pictures from the gallery (and the camera on phones): profile pictures,
roshetta photos, lab results and X-rays, with a zoomable full-screen viewer.
Pictures are shrunk and saved on the device. Needs the `image_picker` package.
- iOS: add `NSPhotoLibraryUsageDescription` and `NSCameraUsageDescription` to `ios/Runner/Info.plist`.
- Android: nothing to add.

## Saved data
Data is saved on the device (shared_preferences) and you stay logged in. To reset to the demo data, clear the app data or uninstall.

## Not done on purpose
Real QR/camera scanner, real sync.
Names and notes typed by users (e.g. "Dr. Omar Hassan", "Blood pressure checked") are data, so they stay in the language they were written in.
