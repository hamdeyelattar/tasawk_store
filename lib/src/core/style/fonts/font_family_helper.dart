import 'package:tasawk/src/core/service/shared_pref/pref_keys.dart';
import 'package:tasawk/src/core/service/shared_pref/shared_pref.dart';

class FontFamilyHelper {
  FontFamilyHelper._();
  static const String cairoArabic = 'Cairo';

  static const String poppinsEnglish = 'Poppins';
  static String geLocalozedFontFamily() {
    final currentLanguage = SHP().getString(PrefKeys.language);
    return currentLanguage == 'ar' ? cairoArabic : poppinsEnglish;
  }
}
