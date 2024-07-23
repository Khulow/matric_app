import 'package:flutter/material.dart';
import 'package:matric_app/miscellaneous/constants/image_strings.dart';
import 'package:matric_app/miscellaneous/constants/sizes.dart';
import 'package:matric_app/miscellaneous/constants/text_strings.dart';
import 'package:matric_app/pages/register.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: const Image(
                image: AssetImage(tGoogleLogoImage),
                width: 20.0,
              ),
              onPressed: () {},
              label: const Text(tSignInWithGoogle)),
        ),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
            onPressed: () {
              //incomplete logic need to be integated with firebase database
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Register()));
            },
            child: Text.rich(TextSpan(
                text: tDontHaveAccount,
                style: Theme.of(context).textTheme.bodyLarge,
                children: const [
                  TextSpan(text: tSignUp, style: TextStyle(color: Colors.blue))
                ])))
      ],
    );
  }
}
