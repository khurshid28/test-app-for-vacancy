import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _key = 'locale';
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(_loadInitial(_prefs));

  static Locale _loadInitial(SharedPreferences prefs) {
    final code = prefs.getString(_key);
    return Locale(code ?? 'en');
  }

  void changeLocale(String languageCode) {
    _prefs.setString(_key, languageCode);
    emit(Locale(languageCode));
  }
}
