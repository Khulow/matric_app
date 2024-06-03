import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:matric_app/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/dashboard%20_screen.dart';
import 'package:matric_app/repository/authentication_repository/exceptions/signup_email_password_failure.dart';

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  static AuthenticationRepository get instance => AuthenticationRepository();

  void onReady() {
    // Initialize the firebase
    firebaseUser = Rx<User?>(_auth.currentUser);
    // Then convert it to bind stream to keep the firebase user listening
    firebaseUser.bindStream(_auth.userChanges());
    // If there any changes, it calls this function
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    // Determine the initial screen based on user presence
    user == null
        ? Get.offAll(() => const Dashboard())
        : Get.offAll(() => const Dashboard());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // After account created successfully, redirect user
      Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // After account login successfully, redirect user
      firebaseUser.value != null
          ? Get.offAll(() => const Dashboard())
          : Get.offAll(() => const Dashboard());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        throw const SignUpWithEmailAndPasswordFailure(
            'Invalid email or password. Please check your credentials and try again.');
      } else {
        throw const SignUpWithEmailAndPasswordFailure(
            'An unknown error occurred. Please try again later.');
      }
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure(
          'An unknown error occurred. Please try again later.');
    }
  }
}
