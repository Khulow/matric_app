import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:matric_app/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:matric_app/pages/login_page.dart';
import 'package:matric_app/pages/register_page.dart';
import 'package:matric_app/utils/theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const WelcomeScreen()

        /*  RegistrationScreen(
          showloginPage: () {},
        ) */
        );
  }
}
