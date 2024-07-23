import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:matric_app/features/core/Routes/routes.dart';
import 'package:matric_app/features/core/provider/bottom_nav_bar.dart';
import 'package:matric_app/features/core/provider/quizprovider.dart';
import 'package:matric_app/features/core/provider/auth_provider';
import 'package:matric_app/services/navigation_service.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:matric_app/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //.then((value) => Get.put(AuthenticationRepository()),

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        // Add more providers if needed
      ],
      builder: (context, child) {
        return MaterialApp(
          
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          themeMode: ThemeMode.light,
          //home: const SplashScreen(),
          initialRoute: RouteManager.splashPage,
          onGenerateRoute: RouteManager.generateRoute,
        );
      },
    );
  }
}
