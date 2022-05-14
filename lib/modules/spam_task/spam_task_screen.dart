import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/component.dart';

class SpamTaskSection extends StatelessWidget {
  const SpamTaskSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map<String, dynamic>> spamTaskList = AppCubit.get(context).spamTasks;
        //AppCubit.get(context).check();
        return taskBuilderSection(taskType: spamTaskList,labelHint: 'No Spam Tasks Now');
      },
    );
  }
}
