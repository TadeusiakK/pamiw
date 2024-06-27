import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:pamiw/app/my_app.dart';
import 'package:pamiw/app/provider/theme_provider.dart';
import 'dart:convert';

import 'package:pamiw/app/models/each_day_progress.dart';
import 'package:pamiw/app/models/task.dart';
import 'package:pamiw/app/models/app_user.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

void userID() async {
  // ignore: avoid_print
  print(FirebaseAuth.instance.currentUser!.uid);
}

DateTime now = DateTime.now();
String nowString = DateFormat('d').format(now);

List<Task> tasksList = <Task>[];
List<EachDayProgress> eachDayProgress = <EachDayProgress> [];
int checkedTasks = 0;

void printprogress() {
  // ignore: unused_local_variable
  List<Map<String, dynamic>> eachDayProgressList = eachDayProgress
      .asMap()
      .entries
      .map((entry) => {"eachDayProgress": entry.value.eachDayProgress})
      .toList();
  //print(eachDayProgressList);
}

int swaper = 1;

int chartHelper(List tasksList) {
  if (tasksList.isEmpty) {
    swaper = 1;
  } else {
    swaper = tasksList.length;
  }
  return swaper;
}

void checkedItemCounter() {
  int checkedCounter = 0;
  for (int i = 0; i < tasksList.length; i++) {
    if (tasksList[i].getChecked == true) {
      checkedCounter++;
    }
  }
  checkedTasks = checkedCounter;
}

Future<AppUser> getUser() async {
  Dio dio = Dio();

  final res = await dio.get(
    'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}',
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Map<String, dynamic> appUserJson = json.decode(res.toString());

  AppUser appUser = AppUser.fromJson(appUserJson);

  return appUser;
}

Future createTaskAPI(
    String title, String subTitle, int counter, DateTime last) async {
  // ignore: unused_local_variable
  Response res;
  Dio dio = Dio();

  res = await dio.post(
      'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/tasks',
      data: {
        "taskId": 0,
        "checked": false,
        "title": title,
        "subTitle": subTitle,
        "counter": counter,
        "last": last.toIso8601String(),
      });
}

void updateTaskAPI(bool? newChecked, String newTitle, String newSubTitle,
    int newCounter, DateTime newLast, int? taskId) async {
  // ignore: unused_local_variable
  Response res;
  Dio dio = Dio();

  res = await dio.put(
      'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/tasks/$taskId',
      data: {
        "checked": newChecked,
        "title": newTitle,
        "subTitle": newSubTitle,
        "counter": newCounter,
        "last": newLast.toIso8601String(),
      });
}

void deleteTaskAPI(int? taskId) async {
  // ignore: unused_local_variable
  Response res;
  Dio dio = Dio();

  try {
    res = await dio.delete(
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/tasks/$taskId');
  } catch (e) {
    // ignore: avoid_print
    print("dupa");
    // ignore: avoid_print
    print(e);
  }
}

void updateProgressAPI() async {
  List<Map<String, dynamic>> eachDayProgressList = eachDayProgress
      .asMap()
      .entries
      .map((entry) => {"eachDayProgress": entry.value.eachDayProgress})
      .toList();

  // ignore: unused_local_variable
  Response res;
  Dio dio = Dio();
  try {
    res = await dio.put(
      'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}',
      data: {"eachDayProgress": eachDayProgressList},
    );
  } catch (e) {
    // ignore: avoid_print
    print("dupa");
    // ignore: avoid_print
    print(e);
  }
}

void updateCheckedAPI() async {
  Map<String, dynamic> checkedTasksMap = {"checkedTasks": checkedTasks};

  // ignore: unused_local_variable
  Response res;
  Dio dio = Dio();

  res = await dio.put(
    'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}',
    data: checkedTasksMap,
  );
}
