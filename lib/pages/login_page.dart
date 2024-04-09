
import 'package:flutter/material.dart';
import 'package:matric_app/widgets/appbar.dart';
import 'package:matric_app/widgets/auth_button.dart';
import 'package:matric_app/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Login'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
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
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
