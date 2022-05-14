import 'package:flutter/material.dart';

import '../shared/style/color.dart';

class MyDefaultButton extends StatelessWidget {
  final Function() onTap;
  final String label;

  const MyDefaultButton({Key? key, required this.onTap, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          end: 15.0,
        ),
        width: 130.0,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: bluish,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
