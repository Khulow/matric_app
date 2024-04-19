import 'package:flutter/material.dart';
import 'package:matric_app/constants/image_strings.dart';
import 'package:matric_app/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key, required this.size});

  final Size size;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: const AssetImage(tWelcomeScreenImage),
            height: size.height * 0.2,
          ),
          Text(tLoginTitle, style: Theme.of(context).textTheme.displayMedium),
          Text(
            tLoginSubTitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
