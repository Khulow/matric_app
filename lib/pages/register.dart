import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/form_header_widget.dart';
import 'package:matric_app/features/authentication/screens/signup/signup_widgets/signup_form_widget.dart';
import 'package:matric_app/miscellaneous/constants/image_strings.dart';
import 'package:matric_app/miscellaneous/constants/sizes.dart';
import 'package:matric_app/miscellaneous/constants/text_strings.dart';
import 'package:matric_app/pages/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(children: [
            FormHeaderWidget(
                image: tWelcomeScreenImage,
                title: tSignupTitle,
                subTitle: tSignSubTitle,
                size: size),
            const SignUpFormWidget(),
            Column(
              children: [
                const Text("OR"),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Image(
                        image: AssetImage(tGoogleLogoImage), width: 20.0),
                    label: Text(tSignInWithGoogle.toUpperCase()),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      //incomplete logic need to be integated with firebase database
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: tAlreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(text: tLogin.toUpperCase())
                    ])))
              ],
            ),
          ]),
        ),
      ),
    ));
  }
}
