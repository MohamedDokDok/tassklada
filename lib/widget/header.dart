import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modules/add_task/add_task_screen.dart';
import '../shared/component.dart';
import '../shared/style/text_style.dart';
import 'deault_button.dart';

class HeaderDateAndTaskButton extends StatelessWidget {
  const HeaderDateAndTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        top: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: dateHeaderStyle(),
              ),
              Text(
                'ToDay',
                style: subHeaderStyle(),
              ),
            ],
          ),
          MyDefaultButton(
            onTap: () {
              navigateTO(
                context: context,
                widget: AddTaskScreen(),
              );
            },
            label: '+ Add Task',
          )
        ],
      ),
    );
  }
}
