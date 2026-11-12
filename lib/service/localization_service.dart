import 'package:flutter/widgets.dart';
import 'arabic_strings.dart';

/// Arabic / English text.
/// English text is the key: in English the key itself is shown, in Arabic the
/// text is looked up in [kArabicStrings]. Use it as: context.tr('Save').
/// Placeholders look like {name} and are filled with the second argument.
extension AppLocalization on BuildContext {
  bool get isAr => Localizations.localeOf(this).languageCode == 'ar';

  String tr(String key, [Map<String, String>? args]) {
    var text = isAr ? (kArabicStrings[key] ?? key) : key;
    args?.forEach((k, v) {
      text = text.replaceAll('{$k}', v);
    });
    return text;
  }
}
