import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matric_app/services/helper_user.dart';

class UserService with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;

  void setCurrentUserNull() {
    _currentUser = null;
  }

  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  Future<String> resetPassword(String email) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Busy sending reset instructions...please wait...';
    notifyListeners();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> loginUser(String email, String password) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Busy logging you in...please wait...';
    notifyListeners();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = userCredential.user;
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Busy signing you out...please wait...';
    notifyListeners();
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      result = e.toString();
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _currentUser = user;
      notifyListeners();
    } else {
      result = 'NOT OK';
    }
    return result;
  }

  void checkIfUserExists(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isEmpty) {
      _userExists = false;
    } else {
      _userExists = true;
    }
    notifyListeners();
  }

  Future<String> createUser(String email, String password, String displayName) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Creating a new user...please wait...';
    notifyListeners();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = userCredential.user;

       if (_currentUser != null) {
        await _currentUser!.updateProfile(displayName: displayName);
        await _currentUser!.reload();
      }

      // Add user details to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .set({
        'email': email,
         'name': displayName,
      });
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }
}



Future<void> updateUserDisplayName(String displayName) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      await user.updateDisplayName(displayName);
      await user.reload(); // Important: Reload the user's profile
    } catch (error) {
      print("Error updating user's displayName: $error");
    }
  }
}
