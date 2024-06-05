import 'package:flutter/material.dart';
import 'package:matric_app/constants/image_strings.dart';
import 'package:matric_app/constants/sizes.dart';
import 'package:matric_app/constants/text_strings.dart';
import 'package:matric_app/features/authentication/screens/login/login_footer.dart';
import 'package:matric_app/features/authentication/screens/login/login_form.dart';
import 'package:matric_app/features/authentication/screens/login/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeader(size: size),
                const LoginForm(),
                const LoginFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
