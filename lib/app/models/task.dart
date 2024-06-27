class Task {
  int? taskId;
  bool? checked;
  String title;
  String subTitle;
  int counter;
  DateTime last;

  Task({
    this.taskId,
    required this.checked,
    required this.title,
    required this.subTitle,
    required this.counter,
    required this.last,
  });

  int? get getTaskId => taskId;
  set setTaskId(int? taskId) {
    this.taskId = taskId;
  }

  bool? get getChecked => checked;
  set setChecked(bool? checked) {
    this.checked = checked;
  }

  String get getTitle => title;
  set setTitle(String title) {
    this.title = title;
  }

  String get getSubTitle => subTitle;
  set setSubTitle(String subTitle) {
    this.subTitle = subTitle;
  }

  int get getCounter => counter;
  set setCounter(int counter) {
    if (counter <= 7 && counter >= 1) {
      this.counter = counter;
    } else {
      this.counter = 1;
    }
  }

  DateTime get getLast => last;
  set setLast(DateTime last) {
    this.last = last;
  }

  Task.fromJson(Map<String, dynamic> json)
      : taskId = json['taskId'],
        checked = json['checked'],
        title = json['title'],
        subTitle = json['subTitle'],
        counter = json['counter'],
        last = DateTime.parse(json['last']);

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'checked': checked,
      'title': title,
      'subTitle': subTitle,
      'counter': counter,
      'last': '"${last.toIso8601String()}"',
    };
  }
}
