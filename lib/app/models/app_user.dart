import 'package:pamiw/app/models/task.dart';

class AppUser {
  final String id;
  final List<Task> tasks;

  AppUser({
    required this.id,
    required this.tasks,
  });

  // Jeżeli Twoja struktura zawiera więcej pól, dodaj je tutaj

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      tasks: (json['tasks'] as List<dynamic>).map((taskJson) {
        return Task.fromJson(taskJson);
      }).toList(),
    );
  }

  // Jeżeli Twoja struktura zawiera więcej pól, dodaj je tutaj

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tasks': tasks.map((task) => task.toJson()).toList(),
      // Dodaj więcej pól, jeżeli to konieczne
    };
  }
}
