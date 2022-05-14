import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import '../cubit/cubit.dart';
import '../shared/style/color.dart';
import '../shared/style/text_style.dart';


class DatePickerSection extends StatelessWidget {

   const DatePickerSection({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
        start: 15.0,
        end: 15.0,
      ),
      child: DatePicker(
        DateTime.now(),
        height: 100.0,
        width: 80.0,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: bluish,
        dateTextStyle: datePickerTextStyle(
          size: 26.0,
        ),
        dayTextStyle: datePickerTextStyle(
          size: 14.0,
        ),
        monthTextStyle: datePickerTextStyle(
          size: 14.0,
        ),
        onDateChange: (date) {
          AppCubit.get(context).changeSelectedDate(date: date);
          AppCubit.get(context).getTaskPerSelectedDate();
        },
      ),
    );
  }
}
