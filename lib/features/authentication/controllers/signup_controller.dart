import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matric_app/common_widgets/dialog_helper/dialog_helper.dart';
import 'package:matric_app/repository/authentication_repository/authentication_repository.dart';
import 'package:matric_app/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  // this function from
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) async {
    try {
      await AuthenticationRepository.instance
          .loginUserWithEmailAndPassword(email, password);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      // Handle SignUpWithEmailAndPasswordFailure exception
      DialogHelper.showErrorDialog(Get.context!, 'Login Error', e.message);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      DialogHelper.showErrorDialog(
          Get.context!, 'Login Error', 'Firebase Auth Exception: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      DialogHelper.showErrorDialog(
          Get.context!, 'Login Error', 'Unexpected error occurred: $e');
    }
  }
}

