import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pamiw/app/models/each_day_progress.dart';
import 'package:pamiw/app/models/task.dart';
import 'package:pamiw/app/provider/theme_provider.dart';
import 'package:pamiw/app/widgets/locale_switcher_widget.dart';
import 'package:pamiw/app/widgets/my_drawer.dart';
import 'package:pamiw/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  Locale selectedLocale = const Locale("en");

  Future<List<Task>>? tasksFuture;

  @override
  void initState() {
    tasksFuture = fetchTasks();
    loadTaskData();
    loadProgressData();
    loadCheckedData();
    super.initState();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  void signUserOut() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
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

  Future<List<Task>> fetchTasks() async {
    List<Task> resTaskList = [];

    Response resTask;
    Dio dioTask = Dio();
    resTask = await dioTask.get(
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/tasks');

    Map<String, dynamic> data = json.decode(resTask.toString()) ?? {};

    for (var taskData in data['tasks']) {
      Task task = Task.fromJson(taskData);
      resTaskList.add(task);
    }

    return resTaskList;
  }

  Future loadProgressData() async {
    List<EachDayProgress> resProgressList = [];

    Response resProgress;
    Dio dioProgress = Dio();
    resProgress = await dioProgress.get(
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/eachDayProgress');

    Map<String, dynamic> data = json.decode(resProgress.toString()) ?? [];

    for (var progressData in data['eachDayProgress']) {
      EachDayProgress each = EachDayProgress.fromMap(progressData);
      resProgressList.add(each);
    }

    eachDayProgress = resProgressList;

    setState(() {});
  }

  Future loadCheckedData() async {
    // ignore: unused_local_variable
    int resCheckedTasks;

    Response resChecked;
    Dio dioChecked = Dio();
    resChecked = await dioChecked.get(
      'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}/checkedtasks',
    );

    Map<String, dynamic> data = resChecked.data;
    checkedTasks = data['checkedTasks'];

    setState(() {});
  }

  void addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        taskNameController = TextEditingController(
            text: "${AppLocalizations.of(context)!.task_}${tasksList.length}");
        taskDescriptionController = TextEditingController(
            text: AppLocalizations.of(context)!.description);
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.add_task),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: taskNameController,
              ),
              TextFormField(
                controller: taskDescriptionController,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    surfaceTintColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancel)),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    surfaceTintColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  setState(() {
                    createTaskAPI(
                        taskNameController.text.trim(),
                        taskDescriptionController.text.trim(),
                        0,
                        DateTime.now());
                    addToItemList(taskNameController.text,
                        taskDescriptionController.text, 0, DateTime.now());
                    checkedItemCounter();
                    eachDayProgress[int.parse(nowString)].setValue =
                        (checkedTasks / chartHelper(tasksList) * 100).round();
                    updateProgressAPI();
                    getUser();
                  });
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.save))
          ],
        );
      },
    );
  }

  void addToItemList(String taskName, String taskDescription, int taskPressed,
      DateTime taskDate) {
    int maxId = tasksList.isNotEmpty
        ? tasksList
            .map((task) => task.getTaskId!)
            .reduce((a, b) => a > b ? a : b)
        : -1;

    tasksList.add(
      Task(
        taskId: maxId + 1,
        checked: false,
        title: taskName,
        subTitle: taskDescription,
        counter: taskPressed,
        last: taskDate,
      ),
    );
  }

  void editTask(BuildContext context, int index) {
    taskNameController = TextEditingController(text: tasksList[index].getTitle);
    taskDescriptionController =
        TextEditingController(text: tasksList[index].getSubTitle);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.edit_task),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: taskNameController,
              ),
              TextFormField(
                controller: taskDescriptionController,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasksList[index].setTitle = taskNameController.text;
                  tasksList[index].setSubTitle = taskDescriptionController.text;
                  // ignore: avoid_print
                  print("index");
                  // ignore: avoid_print
                  print(index);
                  updateTaskAPI(
                      tasksList[index].getChecked,
                      taskNameController.text.trim(),
                      taskDescriptionController.text.trim(),
                      tasksList[index].getCounter,
                      tasksList[index].getLast,
                      tasksList[index].getTaskId);
                  Navigator.pop(context);
                });
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.delete_task),
        content: Text(AppLocalizations.of(context)!
            .do_you_really_want_to_delete_this_task),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                deleteTaskAPI(tasksList[index].getTaskId);
                tasksList.remove(tasksList[index]);
                checkedItemCounter();
                updateCheckedAPI();
                eachDayProgress[int.parse(nowString)].setValue =
                    (checkedTasks / chartHelper(tasksList) * 100).round();
                updateProgressAPI();
                Navigator.of(context).pop();
              });
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.welcome),
        actions: const [
          LocaleSwitcherWidget(),
          SizedBox(width: 12),
        ],
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.blue,
        onPressed: (() {
          tasksFuture = fetchTasks();
          loadProgressData();
          loadCheckedData();
          addTask(context);
          userID();
        }),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Image.asset(
                'assets/DailyDoerLogo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Text(
                  AppLocalizations.of(context)!.tasks_for_today,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${AppLocalizations.of(context)!.remaining_tasks} ${tasksList.length - checkedTasks}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.task_completion_progress,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "${(checkedTasks / chartHelper(tasksList) * 100).round()}%",
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      color: Colors.blue,
                      backgroundColor: const Color.fromARGB(255, 170, 220, 250),
                      value: (checkedTasks / chartHelper(tasksList)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: tasksFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        itemCount: tasksList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: ListTile(
                                title: Text(tasksList[index].getTitle),
                                subtitle: Text(tasksList[index].getSubTitle),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        editTask(context, index);
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteTask(context, index);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                                leading: Checkbox(
                                  activeColor: Colors.blue,
                                  value: tasksList[index].getChecked,
                                  onChanged: ((value) {
                                    setState(
                                      () {
                                        tasksList[index].setChecked = value;
                                        updateTaskAPI(
                                            tasksList[index].getChecked,
                                            tasksList[index].getTitle,
                                            tasksList[index].getSubTitle,
                                            tasksList[index].getCounter,
                                            tasksList[index].getLast,
                                            tasksList[index].taskId);
                                        if (value == true) {
                                          DateTime latestUpdate =
                                              DateTime.now();
                                          if (tasksList[index].getCounter < 1) {
                                            tasksList[index].setCounter =
                                                tasksList[index].getCounter + 1;
                                            tasksList[index].setLast =
                                                latestUpdate;
                                            updateTaskAPI(
                                                tasksList[index].getChecked,
                                                tasksList[index].getTitle,
                                                tasksList[index].getSubTitle,
                                                tasksList[index].getCounter,
                                                tasksList[index].getLast,
                                                tasksList[index].taskId);
                                          }
                                          if (tasksList[index].getCounter >=
                                                  1 &&
                                              latestUpdate.difference(
                                                      tasksList[index]
                                                          .getLast) >=
                                                  const Duration(hours: 24)) {
                                            tasksList[index].setCounter =
                                                tasksList[index].getCounter + 1;
                                            tasksList[index].setLast =
                                                latestUpdate;
                                            updateTaskAPI(
                                                tasksList[index].getChecked,
                                                tasksList[index].getTitle,
                                                tasksList[index].getSubTitle,
                                                tasksList[index].getCounter,
                                                tasksList[index].getLast,
                                                tasksList[index].taskId);
                                          }
                                        }
                                        checkedItemCounter();
                                        updateCheckedAPI();
                                        eachDayProgress[int.parse(nowString)]
                                            .setValue = (checkedTasks /
                                                chartHelper(tasksList) *
                                                100)
                                            .round();
                                        updateProgressAPI();
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
