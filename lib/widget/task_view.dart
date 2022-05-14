import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';
import '../shared/style/color.dart';

class TaskViewSection extends StatelessWidget {
  const TaskViewSection({
    Key? key,
    required this.index,
    required this.taskType,
  }) : super(key: key);

  final int index;
  final List<Map> taskType;


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taskType[index]['id'].toString()),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          AppCubit.get(context).deleteDataFromDataBase(taskType[index]['id']);
        } else {
          if (taskType[index]['isComplete'] == 0) {
            AppCubit.get(context).updateDataIntoDataBase(
                isComplete: 1, id: taskType[index]['id']);
          } else if (taskType[index]['isComplete'] == 1) {
            AppCubit.get(context).updateDataIntoDataBase(
                isComplete: 2, id: taskType[index]['id']);
          } else {
            AppCubit.get(context).deleteDataFromDataBase(taskType[index]['id']);
          }
        }
      },
      background: Container(
        margin: const EdgeInsetsDirectional.only(
          start: 15.0,
          end: 15.0,
          bottom: 15.0,
        ),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: _taskDismissibleBackground(
            backgroundColor: Colors.red,
            alignment: CrossAxisAlignment.start,
                rightIcon: Icons.delete_rounded,
            label:  'Remove',
          ),
        ),
      ),
      secondaryBackground: _taskDismissibleBackground(
        backgroundColor: taskType[index]['isComplete'] == 2 ? Colors.red : pink,
        alignment: CrossAxisAlignment.end,
        rightIcon: taskType[index]['isComplete'] == 0
            ? Icons.done_all_rounded
            : taskType[index]['isComplete'] == 1
                ? Icons.block_rounded
                : Icons.delete_rounded,
        label: taskType[index]['isComplete'] == 0
            ? 'Done'
            : taskType[index]['isComplete'] == 1
                ? 'Spam'
                : 'Remove',
      ),
      child: Card(
        margin: const EdgeInsetsDirectional.only(
          start: 15.0,
          end: 15.0,
          bottom: 15.0,
        ),
        color: taskType[index]['color'] == '0'
            ? bluish
            : taskType[index]['color'] == '1'
                ? yellow
                : pink,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskType[index]['title'],
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          '${taskType[index]['startTime']} - ${taskType[index]['endTime']}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      taskType[index]['note'],
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: 1.0,
                height: 60.0,
                margin: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
              ),
              Transform.rotate(
                angle: 1.6,
                origin: const Offset(0.0, 0.0),
                child: Text(
                  taskType[index]['isComplete'] == 0 ? 'ToDo' : taskType[index]['isComplete'] == 1 ?'Complete' : 'Spam',
                  style: TextStyle(
                    fontSize: 15.0,
                    height: 0.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskDismissibleBackground({
    required Color backgroundColor,
    required CrossAxisAlignment alignment,
    required IconData rightIcon,
    required String label,
  }) =>
      Container(
        margin: const EdgeInsetsDirectional.only(
          start: 15.0,
          end: 15.0,
          bottom: 15.0,
        ),
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: alignment,
            children: [
              Icon(
                rightIcon,
                size: 50.0,
                color: Colors.white,
              ),
              Text(
                label,
                style:TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
}
