import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({super.key, 
  required this.image, 
  required this.title, 
  required this.subTitle, 
  required this.size});

  final String image, title, subTitle;

  final Size size;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: 
        MainAxisAlignment.center,
        children: [
          Image(
            image:  AssetImage(image),
            height: size.height * 0.2,
          ),
          Text(title, style: Theme.of(context).textTheme.displayMedium),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
