
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorWidget extends StatelessWidget {
  final dynamic error;

  const AuthErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    String errorMessage = 'An error occurred';

    if (error is FirebaseAuthException) {
      switch ((error as FirebaseAuthException).code) {
        case 'user-not-found':
          errorMessage = 'User not found';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email already in use';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak';
          break;
        // Add more cases as needed for other error codes
        default:
          errorMessage = 'An error occurred';
          break;
      }
    }

    return Text(errorMessage, style: const TextStyle(color: Colors.red));
  }
}
