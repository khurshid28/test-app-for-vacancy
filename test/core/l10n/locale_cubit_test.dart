import 'dart:ui';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/l10n/locale_cubit.dart';

void main() {
  group('LocaleCubit', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    LocaleCubit buildCubit() => LocaleCubit(prefs);

    test('initial state is Locale("en")', () {
      expect(buildCubit().state, const Locale('en'));
    });

    blocTest<LocaleCubit, Locale>(
      'emits [Locale("ru")] when changed to Russian',
      build: buildCubit,
      act: (cubit) => cubit.changeLocale('ru'),
      expect: () => [const Locale('ru')],
    );

    test('persists locale preference', () async {
      final cubit = buildCubit();
      cubit.changeLocale('ru');
      expect(prefs.getString('locale'), 'ru');
    });

    test('loads saved locale on init', () async {
      SharedPreferences.setMockInitialValues({'locale': 'ru'});
      final newPrefs = await SharedPreferences.getInstance();
      final cubit = LocaleCubit(newPrefs);
      expect(cubit.state, const Locale('ru'));
    });
  });
}
