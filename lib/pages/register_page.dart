import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matric_app/widgets/appbar.dart';
import 'package:matric_app/widgets/auth_button.dart';
import 'package:matric_app/widgets/custom_textfield.dart';

class RegistrationScreen extends StatelessWidget {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController =
      TextEditingController();

  RegistrationScreen({super.key}); // Added for display name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Register'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            CustomTextField(
              // Added for display name
              controller: displayNameController,
              labelText: 'Display Name',
            ),
            const SizedBox(height: 20), // Adjusted size here
            AuthButton(
              text: 'Register',
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  String userId = userCredential.user!.uid;

                  // Create a new document in the 'users' collection with the user's ID
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .set({
                    'displayName': displayNameController.text,
                    'email': emailController.text,
                  });

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
