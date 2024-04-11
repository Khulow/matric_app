

import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
