import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pamiw/app/models/each_day_progress.dart';
import 'package:pamiw/app/models/task.dart';
import 'package:pamiw/app/provider/theme_provider.dart';
import 'package:pamiw/app/widgets/locale_switcher_list_widget.dart';
import 'package:pamiw/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

void signUserOut() async {
  tasksList = <Task>[];
  eachDayProgress = <EachDayProgress>[];
  checkedTasks = 0;
  FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isDarkMode = false;

  File? _image;

  @override
  void initState() {
    super.initState();
    _getImage().then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'profile_image.png';
      // ignore: unused_local_variable
      final savedImage = await _image!.copy('${appDir.path}/$fileName');
      //print('Image saved to ${savedImage.path}');
    }
  }

  Future<File?> _getImage() async {
    final appDir = await getApplicationDocumentsDirectory();
    const fileName = 'profile_image.png';
    final imageFile = File('${appDir.path}/$fileName');
    if (await imageFile.exists()) {
      return imageFile;
    } else {
      return null;
    }
  }

  // ignore: unused_element
  void _updateImage(File image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/profile.png')
                          as ImageProvider<Object>,
                ),
                const SizedBox(height: 20),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.tasks),
            leading: const Icon(Icons.task_alt_rounded),
            onTap: () {
              Navigator.of(context).pushNamed('/tasks');
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.progress),
            leading: const Icon(Icons.timeline_rounded),
            onTap: () {
              Navigator.of(context).pushNamed('/progress');
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.calendar),
            leading: const Icon(Icons.calendar_month_rounded),
            onTap: () {
              Navigator.of(context).pushNamed('/calendar');
            },
          ),
          ExpansionTile(
            title: Text(AppLocalizations.of(context)!.setings),
            leading: const Icon(Icons.settings),
            children: [
              ListTile(
                title: Text(
                  isDarkMode
                      ? AppLocalizations.of(context)!.dark_theme
                      : AppLocalizations.of(context)!.light_theme,
                  style: const TextStyle(fontSize: 16),
                ),
                leading: isDarkMode
                    ? const Icon(Icons.nightlight_round)
                    : const Icon(Icons.wb_sunny),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                  setState(() {
                    isDarkMode =
                        Provider.of<ThemeProvider>(context, listen: false)
                            .isDarkMode;
                  });
                },
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context)!.change_profile_picture),
                leading: const Icon(Icons.image_rounded),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
              ),
              const LocaleSwitcherListWidget(),
            ],
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.sign_out),
            leading: const Icon(Icons.login_rounded),
            onTap: () {
              signUserOut();
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
