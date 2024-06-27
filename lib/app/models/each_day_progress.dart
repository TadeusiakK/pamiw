class EachDayProgress {
  int eachDayProgress;

  EachDayProgress({
    required this.eachDayProgress,
  });

  int get geteachDayProgress => eachDayProgress;
  set setValue(int eachDayProgress) =>
      this.eachDayProgress = eachDayProgress;

  EachDayProgress.fromMap(Map map) : eachDayProgress = map['eachDayProgress'];

  Map toMap() {
    return {
      'eachDayProgress': eachDayProgress,
    };
  }
}
