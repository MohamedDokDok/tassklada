import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tasklada_app/shared/style/color.dart';

import '../cubit/cubit.dart';
import '../widget/task_view.dart';

void navigateTO({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );

void navigateAndTerminateLast({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),
    );

OutlineInputBorder borderTextFromFiled({
  required Color borderColor,
}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: borderColor,
      ),
    );

Widget taskBuilderSection(
        {required List<Map<String, dynamic>> taskType,
        required String labelHint}) =>
    ConditionalBuilder(
      condition: taskType.isNotEmpty,
      builder: (context) => Expanded(
        child: ListView.builder(
            itemCount: taskType.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => TaskViewSection(
                  index: index,
                  taskType: taskType,
                )),
      ),
      fallback: (context) => Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 350.0,
                alignment: AlignmentDirectional.bottomCenter,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/empty_day_task.png',
                    ),
                  ),
                ),
              ),
              Text(
                labelHint,
                style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color:
                        AppCubit.get(context).isDark ? Colors.white : bluish),
              ),
            ],
          ),
        ),
      ),
    );
