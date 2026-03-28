// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Business Hub';

  @override
  String get login => 'Log In';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue managing your businesses';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String get validationPasswordShort =>
      'Password must be at least 6 characters';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get myBusinesses => 'My Businesses';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get employees => 'Employees';

  @override
  String get businesses => 'Businesses';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String employeesCount(int count) {
    return '$count employees';
  }

  @override
  String revenue(String amount) {
    return '\$$amount';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkModeSubtitle => 'Switch between light and dark theme';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Choose your preferred language';

  @override
  String get english => 'English';

  @override
  String get russian => 'Русский';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Log Out';

  @override
  String get logoutSubtitle => 'Sign out of your account';

  @override
  String get logoutConfirmTitle => 'Log Out?';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get retry => 'Retry';

  @override
  String get errorOccurred => 'Something went wrong';

  @override
  String get noBusinesses => 'No businesses found';

  @override
  String get retail => 'Retail';

  @override
  String get service => 'Service';

  @override
  String get technology => 'Technology';

  @override
  String get food => 'Food & Beverage';

  @override
  String get noInternet => 'No Internet Connection';

  @override
  String get noInternetSubtitle =>
      'Please check your Wi-Fi or mobile data and try again';

  @override
  String get tryAgain => 'Try Again';
}
