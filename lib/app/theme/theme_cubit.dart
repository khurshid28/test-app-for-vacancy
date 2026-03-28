import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const _key = 'theme_mode';
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(_loadInitial(_prefs));

  static ThemeMode _loadInitial(SharedPreferences prefs) {
    final value = prefs.getString(_key);
    return value == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDark => state == ThemeMode.dark;

  void toggle() {
    final newMode =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _prefs.setString(_key, newMode == ThemeMode.dark ? 'dark' : 'light');
    emit(newMode);
  }
}
