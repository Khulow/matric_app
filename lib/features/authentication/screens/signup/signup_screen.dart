import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/Form/form_header_widget.dart';
import 'package:matric_app/constants/colors.dart';
import 'package:matric_app/constants/image_strings.dart';
import 'package:matric_app/constants/sizes.dart';
import 'package:matric_app/constants/text_strings.dart';

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
                  Container(
                    padding: const EdgeInsets.all(tDefaultSize),
                    child: const Form(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                         

                        )
                      ],
                    )),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
