import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matric_app/common_widgets/dialogs.dart';
import 'package:matric_app/features/core/Routes/routes.dart';
import 'package:matric_app/services/navigation_service.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name,}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || name.isEmpty || password.isEmpty) {
    showSnackBar(
      context,
      'Please enter all fields!',
    );
  } else {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {

        await user.updateProfile(displayName: name.trim());
        await user.reload();

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email.trim(),
          'name': name.trim(),
        });

        showSnackBar(context, 'New user successfully created!');
        Navigator.of(context).popAndPushNamed(RouteManager.loginPage);
        //Navigator.pop(context);
      } else {
        showSnackBar(context, 'User creation failed. Please try again.');
      }
    } catch (e) {
      showSnackBar(context, getHumanReadableError(e.toString()));
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please enter both fields!');
  } else {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {

        await context.read<UserService>().loginUser(email, password);
        
        navigatorKey.currentState
            ?.popAndPushNamed(RouteManager.mainPage);
      } else {
        showSnackBar(context, 'Login failed. Please try again.');
      }
    } catch (e) {
      showSnackBar(context, getHumanReadableError(e.toString()));
    }
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context,
        'Please enter your email address then click on Reset Password again!');
  } else {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      showSnackBar(
          context, 'Successfully sent password reset. Please check your mail');
    } catch (e) {
      showSnackBar(context, getHumanReadableError(e.toString()));
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    context.read<UserService>().setCurrentUserNull();
    
   navigatorKey.currentState?.popAndPushNamed(RouteManager.loginPage);
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('email address is already in use by another account')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('firebase_auth/invalid-credential')) {
    return 'Please check your username or password. The combination does not match any entry in our database.';
  }
  if (message
      .contains('The email address is badly formatted.')) {
    return 'Your account has been disabled. Please contact support.';
  }
  if (message
      .contains('There is no user record corresponding to this identifier.')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'A network error (such as timeout, interrupted connection or unreachable host) has occurred.')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
}


