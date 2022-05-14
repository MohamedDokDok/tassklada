import 'package:flutter/material.dart';

import '../cubit/cubit.dart';
import '../shared/component.dart';
import '../shared/style/color.dart';

class MyTextFormFiled extends StatelessWidget {
  TextEditingController controller;
  bool readonly;
  String hintLabel;
  String emptyFiledTitle;
  Widget? suffixIconWidget;

  MyTextFormFiled({
    Key? key,
    required this.controller,
    required this.readonly,
    required this.hintLabel,
    required this.emptyFiledTitle,
    this.suffixIconWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      scrollPhysics: const BouncingScrollPhysics(),
      validator: (String? date) {
        if (date!.isEmpty) {
          return emptyFiledTitle;
        } else {
          return null;
        }
      },
      readOnly: readonly,
      cursorColor: bluish,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: hintLabel,
        hintStyle: TextStyle(
            color: AppCubit.get(context).isDark
                ? Colors.white70
                : Colors.grey.shade400),
        enabledBorder: borderTextFromFiled(
          borderColor:
              AppCubit.get(context).isDark ? Colors.white70 : Colors.grey,
        ),
        focusedBorder: borderTextFromFiled(
          borderColor: AppCubit.get(context).isDark ? Colors.white : bluish,
        ),
        errorBorder: borderTextFromFiled(
          borderColor: Colors.red,
        ),
        suffixIconColor:
            AppCubit.get(context).isDark ? Colors.white : Colors.grey,
        suffixIcon: suffixIconWidget,
      ),
    );
  }
}
