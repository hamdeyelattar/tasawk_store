import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/core/service/shared_pref/pref_keys.dart';
import 'package:tasawk/src/core/service/shared_pref/shared_pref.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial());

  bool isDark = true;

  String currentLangCode = 'en';

  Future<void> changeThemeMode({bool? themeMode}) async {
    if (themeMode != null) {
      isDark = themeMode;
      emit(AppState.themeChangeMode(isDark: isDark));
    } else {
      isDark = !isDark;
      await SHP()
          .setBoolean(PrefKeys.themeMode, isDark)
          .then((value) => emit(AppState.themeChangeMode(isDark: isDark)));
    }
  }

  Future<void> getSavedLang() async {
    final res = SHP().containPreference(PrefKeys.language)
        ? SHP().getString(PrefKeys.language)
        : 'en';
    currentLangCode = res!;
    emit(AppState.languageChange(locale: Locale(currentLangCode)));
  }

  Future<void> _changeLang(String langCode) async {
    await SHP().setString(PrefKeys.language, langCode);
    currentLangCode = langCode;
    emit(AppState.languageChange(locale: Locale(currentLangCode)));
  }

  void toArabic() => _changeLang('ar');

  void toEnglish() => _changeLang('en');
}
