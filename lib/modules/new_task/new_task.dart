import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/component.dart';
class NewTaskSection extends StatelessWidget {
  const NewTaskSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map<String, dynamic>> newTaskList = AppCubit.get(context).newTaskPerDate;
        return taskBuilderSection(taskType: newTaskList,labelHint: 'No Tasks For This Day');
      },
    );
  }
}
