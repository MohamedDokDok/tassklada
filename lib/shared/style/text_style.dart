import 'package:flutter/material.dart';
import '../../cubit/cubit.dart';

TextStyle dateHeaderStyle() => TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: AppCubit().isDark ? Colors.grey.shade400  : Colors.grey,
);

TextStyle subHeaderStyle() => TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  height: 1.3,
);

TextStyle datePickerTextStyle({
  required double size,
  Color color = Colors.grey,
  FontWeight fontWeight = FontWeight.w800,
}) => TextStyle(
    fontSize: size,
    fontWeight: fontWeight,
    color: color,
);