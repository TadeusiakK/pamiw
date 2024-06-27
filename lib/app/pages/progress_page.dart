import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pamiw/app/models/charts_builder.dart';
import 'package:pamiw/app/models/task.dart';
import 'package:pamiw/app/provider/theme_provider.dart';
import 'package:pamiw/app/widgets/my_drawer.dart';
import 'package:pamiw/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    loadTaskData();
    super.initState();
  }

  Future loadTaskData() async {
    List<Task> resTaskList = [];

    Response resTask;
    Dio dioTask = Dio();
    resTask = await dioTask.get(
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/tasks');

    Map<String, dynamic> data = json.decode(resTask.toString()) ?? [];

    for (var taskData in data['tasks']) {
      Task task = Task.fromJson(taskData);
      resTaskList.add(task);
    }
    tasksList = resTaskList;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.monthly_progress,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                )),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              children: const [
                SizedBox(
                  height: 200,
                  child: LineChartSample1(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.weekly_progress,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                )),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                      leading: CircularProgressIndicator(
                        color: Colors.green,
                        strokeWidth: 7.5,
                        backgroundColor:
                            const Color.fromARGB(255, 170, 240, 170),
                        value: (tasksList[index].getCounter / 7),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tasksList[index].getTitle,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                              "${((tasksList[index].getCounter / 7) * 100).round()}%",
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
