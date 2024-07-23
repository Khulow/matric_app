import 'package:flutter/material.dart';
import 'package:matric_app/features/core/screens/authentication/authentication_wrapper.dart';
import 'package:matric_app/features/core/screens/dashboard/SpashScreen.dart';
import 'package:matric_app/features/core/screens/dashboard/dashboard%20_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/main_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/profile_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/quiz_instruction_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/quiz_list_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/quiz_result_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/quiz_settings_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/quizscreen.dart';
import 'package:matric_app/pages/loading.dart';
import 'package:matric_app/pages/login.dart';
import 'package:matric_app/pages/register.dart';

class RouteManager {

  static const String splashPage = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String mainPage = '/mainPage';
  static const String quizListPage = '/quizListPage';
  static const String loadingPage = '/loadingPage';
  static const String quizScreenPage = '/quizScreenPage';
  static const String quizSettingsPage = '/quizSettingsPage';
  static const String dashboardPage = '/dashboardScreenPage';
  static const String profilePage = '/profilePage';
  static const String quizResultPage = '/quizResultPage';
  static const String authenticationWrapper = '/authenticationWrapper';
  

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const  Register(),
        );

      case mainPage:
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const Loading(),
        );

      case quizListPage:
        return MaterialPageRoute(
          builder: (context) => const QuizListScreen(),
        );

        case quizScreenPage:
          return MaterialPageRoute(
            builder: (context) => const QuizScreen(),
          );

        case quizSettingsPage:
          return MaterialPageRoute(
            builder: (context) => const QuizSettingsScreen(),
          );

        case dashboardPage: return MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        );

        case profilePage: return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

        case quizResultPage: return MaterialPageRoute(
          builder: (context) => const QuizResultScreen(),
        );

        case authenticationWrapper: return MaterialPageRoute(
          builder: (context) => const AuthenticationWrapper(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
