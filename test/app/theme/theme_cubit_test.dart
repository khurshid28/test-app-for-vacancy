import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/app/theme/theme_cubit.dart';

void main() {
  group('ThemeCubit', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    ThemeCubit buildCubit() => ThemeCubit(prefs);

    test('initial state is ThemeMode.light', () {
      expect(buildCubit().state, ThemeMode.light);
    });

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.dark] when toggled from light',
      build: buildCubit,
      act: (cubit) => cubit.toggle(),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.dark, ThemeMode.light] when toggled twice',
      build: buildCubit,
      act: (cubit) {
        cubit.toggle();
        cubit.toggle();
      },
      expect: () => [ThemeMode.dark, ThemeMode.light],
    );

    test('persists dark theme preference', () async {
      final cubit = buildCubit();
      cubit.toggle();
      expect(prefs.getString('theme_mode'), 'dark');
    });

    test('loads saved dark theme on init', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
      final newPrefs = await SharedPreferences.getInstance();
      final cubit = ThemeCubit(newPrefs);
      expect(cubit.state, ThemeMode.dark);
    });
  });
}
