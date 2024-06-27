import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pamiw/app/pages/auth_page.dart';
import 'package:pamiw/app/pages/tasks_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const TasksPage();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong. Try Again!"),
            );
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
