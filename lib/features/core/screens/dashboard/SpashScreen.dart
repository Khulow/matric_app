import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matric_app/features/core/Routes/routes.dart';
import 'package:matric_app/services/navigation_service.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkLoginStatus());
  }

 Future<void> _checkLoginStatus() async {

     await Future.delayed(const Duration(seconds: 3));

    final userService = Provider.of<UserService>(context,
        listen: false); // Using Provider for state management
    String loginStatus = await userService.checkIfUserLoggedIn();
    if (loginStatus == 'OK') {
       navigatorKey.currentState?.popAndPushNamed(RouteManager.mainPage);
    } else {
       navigatorKey.currentState?.popAndPushNamed(RouteManager.loginPage);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/animations/loading.json', // Path to your Lottie animation file
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
