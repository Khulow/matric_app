import 'package:flutter/material.dart';

class SubjectSectionHeader extends StatelessWidget {
  final VoidCallback onPressed;

  const SubjectSectionHeader({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'SUBJECTS',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              "View All",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}
