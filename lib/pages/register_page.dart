import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matric_app/widgets/appbar.dart';
import 'package:matric_app/widgets/auth_button.dart';
import 'package:matric_app/widgets/custom_textfield.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Register'),
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
              text: 'Register',
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  // Navigate to home screen
                } catch (e) {
                  // Handle registration errors
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
