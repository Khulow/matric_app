import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/app_textfield.dart';
import 'package:matric_app/features/core/screens/dashboard/app_progress_indicator.dart';
import 'package:matric_app/miscellaneous/constants/sizes.dart';
import 'package:matric_app/miscellaneous/constants/text_strings.dart';
import 'package:matric_app/services/helper_user.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              labelText: 'Please enter email address',
            ),
            const SizedBox(height: tFormHeight - 20),
            AppTextField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              labelText: 'Please enter password',
              hideText: true,
            ),
            const SizedBox(height: tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Implement forget password functionality
                },
                child: const Text(tForgetPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  loginUserInUI(context,
                      email: emailController.text,
                      password: passwordController.text);
                },
                child: Text(tLogin.toUpperCase()),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
