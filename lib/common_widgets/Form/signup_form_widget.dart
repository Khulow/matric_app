import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matric_app/constants/sizes.dart';
import 'package:matric_app/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matric_app/features/core/screens/quiz_list_screen.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneNoController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: tFullName,
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: tEmail,
                prefixIcon: Icon(Icons.email_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: phoneNoController,
              decoration: const InputDecoration(
                labelText: tPhoneNo,
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: tPassword,
                prefixIcon: Icon(Icons.lock_rounded),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      UserCredential userCredential =
                          await auth.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      // Add user details to Firestore
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .set({
                        'fullName': fullNameController.text.trim(),
                        'email': emailController.text.trim(),
                        'phoneNo': phoneNoController.text.trim(),
                      });
                      // Navigate to the next screen after successful registration
                      // You can replace '/home' with your desired route
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizListScreen()));
                    } catch (e) {
                      // Show error message to the user
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
                child: Text(tSignUp.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
