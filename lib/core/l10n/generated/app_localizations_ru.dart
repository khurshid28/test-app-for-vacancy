// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Бизнес Хаб';

  @override
  String get login => 'Войти';

  @override
  String get email => 'Электронная почта';

  @override
  String get password => 'Пароль';

  @override
  String get emailHint => 'Введите вашу почту';

  @override
  String get passwordHint => 'Введите ваш пароль';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get orContinueWith => 'или продолжить с';

  @override
  String get dontHaveAccount => 'Нет аккаунта?';

  @override
  String get signUp => 'Регистрация';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get loginSubtitle => 'Войдите, чтобы управлять бизнесом';

  @override
  String get validationEmailRequired => 'Введите почту';

  @override
  String get validationEmailInvalid => 'Введите корректную почту';

  @override
  String get validationPasswordRequired => 'Введите пароль';

  @override
  String get validationPasswordShort =>
      'Пароль должен быть не менее 6 символов';

  @override
  String get dashboard => 'Главная';

  @override
  String get settings => 'Настройки';

  @override
  String get profile => 'Профиль';

  @override
  String get myBusinesses => 'Мои бизнесы';

  @override
  String get totalRevenue => 'Общий доход';

  @override
  String get employees => 'Сотрудники';

  @override
  String get businesses => 'Бизнесы';

  @override
  String get active => 'Активный';

  @override
  String get inactive => 'Неактивный';

  @override
  String memberSince(String date) {
    return 'Участник с $date';
  }

  @override
  String employeesCount(int count) {
    return '$count сотрудников';
  }

  @override
  String revenue(String amount) {
    return '\$$amount';
  }

  @override
  String get appearance => 'Оформление';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get darkModeSubtitle => 'Переключение между светлой и тёмной темой';

  @override
  String get language => 'Язык';

  @override
  String get languageSubtitle => 'Выберите предпочитаемый язык';

  @override
  String get english => 'English';

  @override
  String get russian => 'Русский';

  @override
  String get account => 'Аккаунт';

  @override
  String get logout => 'Выйти';

  @override
  String get logoutSubtitle => 'Выйти из аккаунта';

  @override
  String get logoutConfirmTitle => 'Выйти?';

  @override
  String get logoutConfirmMessage => 'Вы уверены, что хотите выйти?';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get retry => 'Повторить';

  @override
  String get errorOccurred => 'Что-то пошло не так';

  @override
  String get noBusinesses => 'Бизнесы не найдены';

  @override
  String get retail => 'Розничная торговля';

  @override
  String get service => 'Услуги';

  @override
  String get technology => 'Технологии';

  @override
  String get food => 'Еда и напитки';

  @override
  String get noInternet => 'Нет подключения к интернету';

  @override
  String get noInternetSubtitle =>
      'Проверьте Wi-Fi или мобильные данные и повторите попытку';

  @override
  String get tryAgain => 'Повторить';
}
