import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pamiw/app/services/register_google_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  bool passToggle = true;
  bool confirmPassToggle = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign up
    try {
      if (passwordController.text == confirmPasswordController.text &&
          passwordController.text.length >= 6) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        addUserDetails();

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else if (passwordController.text.isEmpty ||
          emailController.text.isEmpty) {
        Navigator.pop(context);
        showErrorMessage(AppLocalizations.of(context)!.enter_valid_credentials);
      } else if (passwordController.text.length < 6) {
        Navigator.pop(context);
        showErrorMessage(AppLocalizations.of(context)!
            .password_should_be_at_least_6_characters_long);
      } else {
        Navigator.pop(context);
        showErrorMessage(AppLocalizations.of(context)!.passwords_dont_match);
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void addUserDetails() async {
    Response response;
    Dio dio = Dio();

    String apiUrl =
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${FirebaseAuth.instance.currentUser!.uid}';

    try {
      response = await dio.post(apiUrl, data: {
        "name": nameController.text.trim(),
        "password": passwordController.text.trim(),
        "email": emailController.text.trim(),
        "tasks": [],
        "eachDayProgress": [
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0},
          {"eachDayProgress": 0}
        ],
        "checkedTasks": 0,
      });

      if (response.statusCode == 201) {
        // ignore: avoid_print
        print('Informacje o użytkowniku zostały dodane poprawnie.');
      } else {
        // ignore: avoid_print
        print(
            'Błąd podczas dodawania informacji o użytkowniku. Kod odpowiedzi: ${response.statusCode}');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Błąd podczas wysyłania zapytania: $error');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formField,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Image.asset(
                    'assets/DailyDoerLogo.png',
                    width: 300,
                    height: 300,
                  ),

                  const SizedBox(height: 20),

                  //Register now!
                  Text(
                    AppLocalizations.of(context)!.register_now,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(height: 20),

                  //name field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person),
                        labelText: AppLocalizations.of(context)!.name,
                        border: const OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // email field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        labelText: AppLocalizations.of(context)!.email,
                        border: const OutlineInputBorder(),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.enter_email;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return AppLocalizations.of(context)!
                              .enter_valid_email;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // password field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        labelText: AppLocalizations.of(context)!.password,
                        border: const OutlineInputBorder(),
                        filled: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.enter_password;
                        } else if (value.length < 6) {
                          return AppLocalizations.of(context)!
                              .password_should_be_at_least_6_characters_long;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //confirmpassword field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: confirmPasswordController,
                      obscureText: confirmPassToggle,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        labelText:
                            AppLocalizations.of(context)!.confirm_password,
                        border: const OutlineInputBorder(),
                        filled: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              confirmPassToggle = !confirmPassToggle;
                            });
                          },
                          child: Icon(confirmPassToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.enter_password;
                        } else if (value.length < 6) {
                          return AppLocalizations.of(context)!
                              .password_should_be_at_least_6_characters_long;
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: InkWell(
                      onTap: signUp,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.sign_up,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            AppLocalizations.of(context)!.or_continue_with,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // google sign in
                  SizedBox(
                    width: 180,
                    child: ListTile(
                      title: const Center(
                        child: Text(
                          "Google",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/Google.png',
                        height: 40,
                      ),
                      onTap: () {
                        RegisterGoogleService().signInAndSendData();
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Already have an account? Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_an_account,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          AppLocalizations.of(context)!.sign_in,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
