import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/appbar.dart';
import 'package:matric_app/common_widgets/auth_button.dart';
import 'package:matric_app/common_widgets/custom_textfield.dart';

class LoginScreen2 extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final VoidCallback showRegisterPage;
  LoginScreen2({super.key, required this.showRegisterPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
              ),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
              ),
              const SizedBox(
                height: 50,
              ),
              AuthButton(
                text: 'Login',
                onPressed: () async {
                  // Login logic
                },
              ),
              TextButton(
                onPressed: () {
                  // Navigate to registration screen
                },
                child: Text(
                  'Create an account',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
