import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/style/color.dart';
import '../widget/app_bar.dart';
import '../widget/date_picker.dart';
import '../widget/header.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            onPress: () {
              cubit.changeDarkMode();
            },
            title: 'TaskLada',
            titleColor: Colors.white,
            appBarColor: cubit.isDark ? darkGrey : bluish,
            iconColor: Colors.white,
            icon:
                cubit.isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          ),
          body: Column(
            children: <Widget>[
              const HeaderDateAndTaskButton(),
              cubit.currentIndex == 0 ? const DatePickerSection() : Container(),
              const SizedBox(
                height: 10.0,
              ),
              ConditionalBuilder(
                condition: state is! AppGetDataFromDataBaseLoadingState,
                builder: (context) => cubit.taskTypeScreen[cubit.currentIndex],
                fallback: (context) => const CircularProgressIndicator(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20.0,
            currentIndex: cubit.currentIndex,
            selectedItemColor: bluish,
            selectedFontSize: 16,
            unselectedFontSize: 12,
            iconSize: 28,
            onTap: (index) {
              cubit.changeIndexOfBottomNavBar(index: index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'New Task',
                icon: Icon(
                  Icons.menu,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Done Task',
                icon: Icon(Icons.check_circle_outline),
              ),
              BottomNavigationBarItem(
                label: 'Spam Task',
                icon: Icon(Icons.block_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}
