import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/Form/form_header_widget.dart';
import 'package:matric_app/common_widgets/Form/signup_form_widget.dart';
import 'package:matric_app/constants/image_strings.dart';
import 'package:matric_app/constants/sizes.dart';
import 'package:matric_app/constants/text_strings.dart';
import 'package:matric_app/features/authentication/screens/login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
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
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
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
