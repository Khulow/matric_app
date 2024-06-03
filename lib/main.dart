import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matric_app/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:matric_app/features/core/model/quizprovider.dart';
import 'package:matric_app/features/core/provider/auth_provider.dart';
import 'package:matric_app/features/core/screens/quiz_list_screen.dart';
import 'package:matric_app/repository/authentication_repository/authentication_repository.dart';
import 'package:matric_app/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) => Get.put(AuthenticationRepository()),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add more providers if needed
      ],
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const WelcomeScreen()
          
          //QuizListScreen(),
        );
      },
    );
  }
}
