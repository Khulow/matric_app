import 'package:flutter/material.dart';
import 'package:matric_app/miscellaneous/constants/colors.dart';
import 'package:matric_app/miscellaneous/constants/image_strings.dart';
import 'package:matric_app/miscellaneous/constants/sizes.dart';
import 'package:matric_app/miscellaneous/constants/text_strings.dart';
import 'package:matric_app/pages/login.dart';
import 'package:matric_app/pages/register.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //to check the height size of the device screen
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: const AssetImage(tWelcomeScreenImage),
                //MAKE THE IMAGE TAKE 60% OF SCREEN
                height: height * 0.6,
              ),
              Column(
                children: [
                  Text(tWelcomeTitle,
                      style: Theme.of(context).textTheme.displaySmall),
                  Text(
                    tWelcomeSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      //add the login logic here
                      onPressed: () {
                        // Navigate to the second screen
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Login()));
                      },

                      child: Text(
                        tGetStarted.toUpperCase(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
