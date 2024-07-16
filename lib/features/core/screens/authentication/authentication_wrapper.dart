import 'package:flutter/material.dart';
import 'package:matric_app/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/main_screen.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, authProvider, child) {
        // Directly check if the user is logged in
        if (authProvider.currentUser != null) {
          return const MainScreen();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
