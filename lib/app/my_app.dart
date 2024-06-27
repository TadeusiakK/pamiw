import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pamiw/app/pages/calendar_page.dart';
import 'package:pamiw/app/pages/progress_page.dart';
import 'package:pamiw/app/pages/tasks_page.dart';
import 'package:pamiw/app/provider/locale_provider.dart';
import 'package:pamiw/app/provider/theme_provider.dart';
import 'package:pamiw/app/pages/main_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ThemeProvider>(context).isDarkMode
                ? ThemeData.dark()
                : ThemeData.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: provider.locale,
            initialRoute: '/',
            routes: {
              '/': (context) => const MainPage(),
              '/tasks': (context) => const TasksPage(),
              '/progress': (context) => const ProgressPage(),
              '/calendar': (context) => const CalendarPage(),
            },
          );
        },
      );
}
