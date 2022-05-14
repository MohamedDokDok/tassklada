import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/task_model.dart';
import '../../shared/style/color.dart';
import '../../widget/app_bar.dart';
import '../../widget/choose_color_widget.dart';
import '../../widget/deault_button.dart';
import '../../widget/text_form_filed.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _remindController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  var createTaskKey = GlobalKey<FormState>();

  AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            onPress: () {
              Navigator.pop(context);
            },
            title: 'Add Task',
            titleColor: cubit.isDark? Colors.white : bluish,
            icon: Icons.arrow_back_ios_rounded,
            iconColor: cubit.isDark ? Colors.white : bluish,
            appBarColor: cubit.isDark ? darkGrey : Colors.white24,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 5.0,
                start: 10.0,
                end: 10.0,
              ),
              child: Form(
                key: createTaskKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _textHeader(headerLabel: 'Title'),
                    MyTextFormFiled(
                      controller: _titleController,
                      hintLabel: 'Enter title here',
                      emptyFiledTitle: 'Title Required',
                      readonly: false,
                    ),
                    _spaceBetweenTextFromFiled(),
                    _textHeader(headerLabel: 'Note'),
                    MyTextFormFiled(
                      controller: _noteController,
                      hintLabel: 'Enter your note',
                      emptyFiledTitle: 'Note Required',
                      readonly: false,
                    ),
                    _spaceBetweenTextFromFiled(),
                    _textHeader(headerLabel: 'Date'),
                    MyTextFormFiled(
                      controller: _dateController,
                      hintLabel: DateFormat.yMMMd().format(DateTime.now()),
                      suffixIconWidget: _suffixIconWidgetDateAndTime( onPress: (){
                        cubit.getDateFromUser(context: context,dateController: _dateController);
                      }, icon: Icons.date_range_outlined,),
                      emptyFiledTitle: 'Date Required',
                      readonly: true,
                    ),
                    _spaceBetweenTextFromFiled(),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _textHeader(headerLabel: 'Start Time'),
                              MyTextFormFiled(
                                controller: _startTimeController,
                                hintLabel: DateFormat('hh:mm a')
                                    .format(DateTime.now()),
                                suffixIconWidget: _suffixIconWidgetDateAndTime(onPress:(){
                                  cubit.getTimeFromUser(context: context, selectedTime: _startTimeController);
                                }, icon: Icons.access_time_outlined,),
                                emptyFiledTitle: 'Start Time Required',
                                readonly: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _textHeader(headerLabel: 'End Time'),
                              MyTextFormFiled(
                                controller: _endTimeController,
                                hintLabel: DateFormat('hh:mm a')
                                    .format(DateTime.now()),
                                suffixIconWidget:_suffixIconWidgetDateAndTime(onPress:(){
                                  cubit.getTimeFromUser(context: context, selectedTime: _endTimeController);
                                }, icon: Icons.access_time_outlined,),
                                emptyFiledTitle: 'End Time Required',
                                readonly: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _spaceBetweenTextFromFiled(),
                    _textHeader(headerLabel: 'Remind'),
                    MyTextFormFiled(
                      controller: _remindController,
                      hintLabel: '5 minutes',
                      suffixIconWidget: cubit.myDropDownButton(
                          list: cubit.remindList,
                          val: 'Minutes',
                          controller: _remindController),
                      emptyFiledTitle: 'Remind Time Required',
                      readonly: true,
                    ),
                    _spaceBetweenTextFromFiled(),
                    _textHeader(headerLabel: 'Repeat'),
                    MyTextFormFiled(
                      controller: _repeatController,
                      hintLabel: 'Daily',
                      suffixIconWidget: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: cubit.myDropDownButton(
                          list: cubit.repeatList,
                          controller: _repeatController,
                        ),
                      ),
                      emptyFiledTitle: 'Repeat Required',
                      readonly: true,
                    ),
                    _spaceBetweenTextFromFiled(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textHeader(headerLabel: 'Color'),
                            const ChooseColorSection(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ConditionalBuilder(
                            condition: state is! InsertDataIntoDataBaseLoadingState,
                            builder: (context) =>  MyDefaultButton(
                              onTap: () {
                                if (createTaskKey.currentState!.validate()) {
                                  cubit.insertIntoDataBase(TaskModel.data(
                                      title: _titleController.text,
                                      note: _noteController.text,
                                      date: _dateController.text,
                                      startTime: _startTimeController.text,
                                      endTime: _endTimeController.text,
                                      remind: _remindController.text,
                                      repeat: _repeatController.text,
                                      color: cubit.selectedColor,
                                      isComplete: 0,)
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              label: 'Create Task',
                            ),
                            fallback: (context) => const CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textHeader({
    required String headerLabel,
  }) =>
      Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: 8.0,
        ),
        child: Text(
          headerLabel,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
          ),
        ),
      );

  Widget _spaceBetweenTextFromFiled() => const SizedBox(
        height: 10.0,
      );

  IconButton _suffixIconWidgetDateAndTime({
    required Function() onPress,
    required IconData icon
  }) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
      ),
    );
  }


}
