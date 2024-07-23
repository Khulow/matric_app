import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/form_header_widget.dart';
import 'package:matric_app/features/core/screens/dashboard/app_progress_indicator.dart';

import 'package:matric_app/miscellaneous/constants/image_strings.dart';
import 'package:matric_app/miscellaneous/constants/sizes.dart';
import 'package:matric_app/features/authentication/screens/login/login_widgets/login_footer.dart';
import 'package:matric_app/features/authentication/screens/login/login_widgets/login_form.dart';
import 'package:matric_app/miscellaneous/constants/text_strings.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormHeaderWidget(
                        image: tWelcomeScreenImage,
                        title: tLoginTitle,
                        subTitle: tLoginSubTitle,
                        size: size),
                    const LoginForm(
                    ),
                    const LoginFooter() 
                  ],
                ),
                
              ),
            ),
            Selector<UserService, Tuple2<bool, String>>(
              selector: (context, userService) => Tuple2(
                  userService.showUserProgress, userService.userProgressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: value.item2)
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
