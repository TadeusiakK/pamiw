import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome!';

  @override
  String buttonPressed(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pressed $count times',
      one: 'Pressed 1 time',
      zero: 'Has not pressed yet',
    );
    return '$_temp0';
  }

  @override
  String get welcome_back_to_dailydoer => 'Welcome back to Daily Doer';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Password';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get sign_in => 'Sign In';

  @override
  String get or_continue_with => 'Or continue with';

  @override
  String get dont_have_an_account => 'Don\'t have an account?';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get light_theme => 'Light theme';

  @override
  String get dark_theme => 'Dark theme';

  @override
  String get language_english => 'Language: English';

  @override
  String get language_polish => 'Language: Polish';

  @override
  String get english => 'English';

  @override
  String get polish => 'Polish';

  @override
  String get enter_valid_credentials => 'Enter valid credentials';

  @override
  String get passwords_dont_match => 'Passwords don\'t match';

  @override
  String get register_now => 'Register now!';

  @override
  String get name => 'Name';

  @override
  String get confirm_password => 'Confirm password';

  @override
  String get already_have_an_account => 'Already have an account?';

  @override
  String get pasword_reseting_link_sent => 'Pasword reseting link sent! Check your email!';

  @override
  String get enter_your_email_and_we_will_send_you_a_password_reset_link => 'Enter your e-mail and we will send you a password reset link!';

  @override
  String get reset_password => 'Reset password';

  @override
  String get enter_email => 'Enter e-mail';

  @override
  String get enter_valid_email => 'Enter valid e-mail';

  @override
  String get enter_password => 'Enter password';

  @override
  String get password_should_be_at_least_6_characters_long => 'Password should be at least 6 characters long';

  @override
  String get tasks => 'Tasks';

  @override
  String get progress => 'Progress';

  @override
  String get calendar => 'Calendar';

  @override
  String get setings => 'Setings';

  @override
  String get change_profile_picture => 'Change profile picture';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get add_task => 'Add task';

  @override
  String get task_ => 'Task_';

  @override
  String get description => 'Description';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit_task => 'Edit task';

  @override
  String get delete_task => 'Delete task?';

  @override
  String get do_you_really_want_to_delete_this_task => 'Do you really want to delete this task?';

  @override
  String get delete => 'Delete';

  @override
  String get tasks_for_today => 'Tasks for today!';

  @override
  String get remaining_tasks => 'Remaining tasks';

  @override
  String get task_completion_progress => 'Task completion progress';

  @override
  String get monthly_progress => 'Monthly progress:';

  @override
  String get weekly_progress => 'Weekly progress:';

  @override
  String get add_appointment => 'Add appointment';

  @override
  String get title => 'Title';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get from => 'Form';

  @override
  String get to => 'To';

  @override
  String get delete_appointment => 'Delete appointment?';

  @override
  String get do_you_really_want_to_delete_this_appointment => 'Do you really want to delete this appointment?';
}
