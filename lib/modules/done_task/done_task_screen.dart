import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/component.dart';

class DoneTaskSection extends StatelessWidget {
  const DoneTaskSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map<String, dynamic>> doneTaskList = AppCubit.get(context).doneTasks;
        return taskBuilderSection(taskType: doneTaskList, labelHint: 'No Complete Tasks Now');
      },
    );
  }
}
