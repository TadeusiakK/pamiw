import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get welcome => 'Witaj!';

  @override
  String buttonPressed(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'naciśnięto $count razy',
      one: 'Naciśnieto 1 raz',
      zero: 'Jeszcze nie naciśnięto',
    );
    return '$_temp0';
  }

  @override
  String get welcome_back_to_dailydoer => 'Witaj ponownie w Daily Doer!';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Hasło';

  @override
  String get forgot_password => 'Zapomniałeś hasła?';

  @override
  String get sign_in => 'Zaloguj się';

  @override
  String get or_continue_with => 'Albo kontynuuj z';

  @override
  String get dont_have_an_account => 'Nie masz jeszcze konta?';

  @override
  String get sign_up => 'Zarejestruj się';

  @override
  String get light_theme => 'Jasny motyw';

  @override
  String get dark_theme => 'Ciemny motyw';

  @override
  String get language_english => 'Język: Angielski';

  @override
  String get language_polish => 'Język: Polski';

  @override
  String get english => 'Angielski';

  @override
  String get polish => 'Polski';

  @override
  String get enter_valid_credentials => 'Wprowadź poprawne dane';

  @override
  String get passwords_dont_match => 'Hasła się nie zgadzają';

  @override
  String get register_now => 'Zarejestruj się!';

  @override
  String get name => 'Imię';

  @override
  String get confirm_password => 'Potwierdź hasło';

  @override
  String get already_have_an_account => 'Masz konto?';

  @override
  String get pasword_reseting_link_sent => 'Wysłano link do resetu hasła! Sprawdź swój email!';

  @override
  String get enter_your_email_and_we_will_send_you_a_password_reset_link => 'Wprowadź e-mail a my wyślemy Ci link do zmainy hasła!';

  @override
  String get reset_password => 'Resetuj hasło';

  @override
  String get enter_email => 'Podaj e-mail';

  @override
  String get enter_valid_email => 'Podaj prawidłowy e-mail';

  @override
  String get enter_password => 'Podaj hasło';

  @override
  String get password_should_be_at_least_6_characters_long => 'Hasło powinno mieć przynajmniej 6 znaków';

  @override
  String get tasks => 'Zadania';

  @override
  String get progress => 'Postępy';

  @override
  String get calendar => 'Kalendarz';

  @override
  String get setings => 'Ustawienia';

  @override
  String get change_profile_picture => 'Zmień zdjęcie profilowe';

  @override
  String get sign_out => 'Wyloguj się';

  @override
  String get add_task => 'Dodaj zadanie';

  @override
  String get task_ => 'Zadanie_';

  @override
  String get description => 'Opis';

  @override
  String get cancel => 'Anuluj';

  @override
  String get save => 'Zapisz';

  @override
  String get edit_task => 'Edytuj zadanie';

  @override
  String get delete_task => 'Usunąć zadanie?';

  @override
  String get do_you_really_want_to_delete_this_task => 'Czy na pewno chcesz usunąć to zadanie?';

  @override
  String get delete => 'Usuń';

  @override
  String get tasks_for_today => 'Zadania na dziś!';

  @override
  String get remaining_tasks => 'Liczba zadań do wykonania';

  @override
  String get task_completion_progress => 'Poziom ukończonych zadań';

  @override
  String get monthly_progress => 'Postępy w tym miesiącu:';

  @override
  String get weekly_progress => 'Postępy w tym tygodnu:';

  @override
  String get add_appointment => 'Dodaj wydarzenie';

  @override
  String get title => 'Tytuł';

  @override
  String get date => 'Data';

  @override
  String get time => 'Czas';

  @override
  String get from => 'Od';

  @override
  String get to => 'Do';

  @override
  String get delete_appointment => 'Usunąć wydarzenie?';

  @override
  String get do_you_really_want_to_delete_this_appointment => 'Czy na pewno chcesz usunąć to wydarzenie?';
}
