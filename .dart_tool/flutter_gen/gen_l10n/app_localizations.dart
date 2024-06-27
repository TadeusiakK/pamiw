import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @buttonPressed.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Has not pressed yet} =1{Pressed 1 time} other{Pressed {count} times}}'**
  String buttonPressed(num count);

  /// No description provided for @welcome_back_to_dailydoer.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to Daily Doer'**
  String get welcome_back_to_dailydoer;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @or_continue_with.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get or_continue_with;

  /// No description provided for @dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_an_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @light_theme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get light_theme;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get dark_theme;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'Language: English'**
  String get language_english;

  /// No description provided for @language_polish.
  ///
  /// In en, this message translates to:
  /// **'Language: Polish'**
  String get language_polish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @polish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get polish;

  /// No description provided for @enter_valid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Enter valid credentials'**
  String get enter_valid_credentials;

  /// No description provided for @passwords_dont_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwords_dont_match;

  /// No description provided for @register_now.
  ///
  /// In en, this message translates to:
  /// **'Register now!'**
  String get register_now;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @pasword_reseting_link_sent.
  ///
  /// In en, this message translates to:
  /// **'Pasword reseting link sent! Check your email!'**
  String get pasword_reseting_link_sent;

  /// No description provided for @enter_your_email_and_we_will_send_you_a_password_reset_link.
  ///
  /// In en, this message translates to:
  /// **'Enter your e-mail and we will send you a password reset link!'**
  String get enter_your_email_and_we_will_send_you_a_password_reset_link;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get reset_password;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter e-mail'**
  String get enter_email;

  /// No description provided for @enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Enter valid e-mail'**
  String get enter_valid_email;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_password;

  /// No description provided for @password_should_be_at_least_6_characters_long.
  ///
  /// In en, this message translates to:
  /// **'Password should be at least 6 characters long'**
  String get password_should_be_at_least_6_characters_long;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @setings.
  ///
  /// In en, this message translates to:
  /// **'Setings'**
  String get setings;

  /// No description provided for @change_profile_picture.
  ///
  /// In en, this message translates to:
  /// **'Change profile picture'**
  String get change_profile_picture;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @add_task.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get add_task;

  /// No description provided for @task_.
  ///
  /// In en, this message translates to:
  /// **'Task_'**
  String get task_;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit_task.
  ///
  /// In en, this message translates to:
  /// **'Edit task'**
  String get edit_task;

  /// No description provided for @delete_task.
  ///
  /// In en, this message translates to:
  /// **'Delete task?'**
  String get delete_task;

  /// No description provided for @do_you_really_want_to_delete_this_task.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this task?'**
  String get do_you_really_want_to_delete_this_task;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @tasks_for_today.
  ///
  /// In en, this message translates to:
  /// **'Tasks for today!'**
  String get tasks_for_today;

  /// No description provided for @remaining_tasks.
  ///
  /// In en, this message translates to:
  /// **'Remaining tasks'**
  String get remaining_tasks;

  /// No description provided for @task_completion_progress.
  ///
  /// In en, this message translates to:
  /// **'Task completion progress'**
  String get task_completion_progress;

  /// No description provided for @monthly_progress.
  ///
  /// In en, this message translates to:
  /// **'Monthly progress:'**
  String get monthly_progress;

  /// No description provided for @weekly_progress.
  ///
  /// In en, this message translates to:
  /// **'Weekly progress:'**
  String get weekly_progress;

  /// No description provided for @add_appointment.
  ///
  /// In en, this message translates to:
  /// **'Add appointment'**
  String get add_appointment;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'Form'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @delete_appointment.
  ///
  /// In en, this message translates to:
  /// **'Delete appointment?'**
  String get delete_appointment;

  /// No description provided for @do_you_really_want_to_delete_this_appointment.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this appointment?'**
  String get do_you_really_want_to_delete_this_appointment;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
