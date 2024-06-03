class SignUpWithEmailAndPasswordFailure {
   final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An Unknown error occured."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "weak-password":
        return const SignUpWithEmailAndPasswordFailure('The password provided is too weak');
       case "invalid email":
        return const SignUpWithEmailAndPasswordFailure('The email address is badly formatted.');
       case "email-already-in-use":
        return const SignUpWithEmailAndPasswordFailure('The email address is already in use by another account.');
       case "operation-not-allowed":
        return const SignUpWithEmailAndPasswordFailure('Email/password accounts are not enabled.');
       case "user-disabled":
        return const SignUpWithEmailAndPasswordFailure('The user account has been disabled by an administrator.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
