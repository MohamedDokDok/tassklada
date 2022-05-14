import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasklada_app/cubit/states.dart';
import '../home_layout/home_layout.dart';
import '../local_data_base/abstract_data_base_model.dart';
import '../models/on_boarding_model.dart';
import '../models/task_model.dart';
import '../modules/done_task/done_task_screen.dart';
import '../modules/new_task/new_task.dart';
import '../modules/on_boarding/on_boarding_screen.dart';
import '../modules/spam_task/spam_task_screen.dart';
import '../shared/component.dart';
import '../shared/local_storage_shared_pref/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  void changeDarkMode({
    bool? sharedPrefData,
  }) {
    if (sharedPrefData != null) {
      isDark = sharedPrefData;
      emit(ChangeThemeMode());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeMode());
      });
    }
  }

  int selectedColor = 0;
  void changeColor({
    required int index,
  }) {
    selectedColor = index;
    emit(ChangeSelectedColor());
  }

  int currentIndex = 0;
  void changeIndexOfBottomNavBar({
    required int index,
  }) {
    currentIndex = index;
    emit(ChangeIndexOfBottomNavBarState());
  }

  List<Widget> taskTypeScreen = [
    const NewTaskSection(),
    const DoneTaskSection(),
    const SpamTaskSection(),
  ];

  final List<int> remindList = [5, 10, 15, 20];
  final List<String> repeatList = ['Daily', 'Weekly', 'Monthly'];
  final String _timeNow = DateFormat('hh:mm a').format(DateTime.now());

  getTimeFromUser({
    required BuildContext context,
    required TextEditingController selectedTime,
  }) =>
      showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_timeNow.split(":")[0]),
          minute: int.parse(_timeNow.split(":")[1].split(" ")[0]),
        ),
      ).then((time) {
        if (time != null) {
          selectedTime.text = time.format(context);
        } else {}
      });

  getDateFromUser({
    required BuildContext context,
    required TextEditingController dateController,
  }) =>
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        confirmText: 'Set',
        helpText: 'Set Date Of Task',
      ).then((DateTime? date) {
        if (date != null) {
          dateController.text = DateFormat.yMMMd().format(date);
        } else {}
      });

  Widget myDropDownButton({
    required List list,
    String? val,
    required TextEditingController controller,
  }) =>
      DropdownButton(
        borderRadius: BorderRadius.circular(30.0),
        underline: Container(),
        items: list.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem(
            value: val == null ? value.toString() : '$value $val',
            child: Text(value.toString()),
          );
        }).toList(),
        onChanged: (newValue) {
          controller.text = newValue.toString();
        },
      );

  late Database database;
  void createDataBase() {
    openDatabase('ToDoDb.db', version: 1, onCreate: (database, version) {
      database
          .execute(
        "CREATE TABLE tasks( "
        "id INTEGER PRIMARY KEY, title TEXT,"
        "note TEXT, date TEXT,"
        "startTime TEXT, endTime TEXT,"
        "remind INTEGER, repeat TEXT,"
        "color TEXT, isComplete BOOLEAN )",
      )
          .then((value) {
        //print('Table is created');
      }).catchError((onError) {
        //print('Error when creating table ${onError.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(CreateDataBaseSuccessState());
    }).catchError((error) {
      //print('Error when creating database ${error.toString()}');
    });
  }

  Future<void> insertIntoDataBase(DatabaseModel model) async {
    emit(InsertDataIntoDataBaseLoadingState());
    await database
        .insert(
      model.tableName(),
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) {
      emit(InsertDataIntoDataBaseSuccessState());
      getDataFromDatabase(database);
    });
  }

  TaskModel model = TaskModel();
  void updateDataIntoDataBase({
    required int isComplete,
    required int id,
  }) {
    emit(UpdateDataIntoDataBaseLoadingState());
    database.rawQuery(
        'UPDATE ${model.tableName()} SET isComplete =? WHERE id =?',
        [isComplete, id]).then((value) {
      emit(UpdateDataIntoDataBaseSuccessState());
    });
    getDataFromDatabase(database);
  }

  void deleteDataFromDataBase(id) {
    emit(DeleteDataFromDataBaseLoadingState());
    database.rawUpdate(
        'DELETE FROM ${model.tableName()} WHERE id =?', [id]).then((value) {});
    emit(DeleteDataFromDataBaseSuccessState());
    getDataFromDatabase(database);
  }

  List<Map<String, dynamic>> doneTasks = [];
  List<Map<String, dynamic>> spamTasks = [];
  void getDataFromDatabase(database) {
    emit(AppGetDataFromDataBaseLoadingState());
    doneTasks = [];
    spamTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        List _taskDate = element['date'].split(' ');
        List _now = DateFormat.yMMMd().format(DateTime.now()).split(' ');
        if (element['isComplete'] == 1) {
          doneTasks.add(element);
        } else if (element['isComplete'] == 2) {
          spamTasks.add(element);
        } else if (element['isComplete'] == 0 &&
            _taskDate[0] == _now[0] &&
            int.parse(_taskDate[1].replaceAll(',', '')) <
                int.parse(_now[1].replaceAll(',', '')) &&
            _taskDate[2] == _now[2]) {
          updateDataIntoDataBase(isComplete: 2, id: element['id']);
        }
      });
      getTaskPerSelectedDate();
      emit(AppGetDataFromDataBaseSuccessState());
    });
  }

  String selectedDate = DateFormat.yMMMd().format(DateTime.now());
  void changeSelectedDate({
    required DateTime date,
  }) {
    selectedDate = DateFormat.yMMMd().format(date);
    emit(ChangeSelectedDateState());
  }

  List<Map<String, dynamic>> newTaskPerDate = [];
  getTaskPerSelectedDate() {
    newTaskPerDate = [];
    database.rawQuery('SELECT * FROM tasks WHERE date = ? AND isComplete = ?',
        [selectedDate, 0]).then((value) {
      newTaskPerDate = value;
      emit(GetTasksPerSelectedDateSuccessState());
    });
  }

  List<OnBoardingModel> onBoardingItem = [
    OnBoardingModel(
        image: 'assets/images/on_boarding_image_1.png',
        title: 'Add Your Daily Tasks',
        body: 'Finish Your Daily Works With Easily Ways And Sample'),
    OnBoardingModel(
        image: 'assets/images/on_boarding_image_2.png',
        title: 'finish ALl Tasks',
        body: 'Check Complete Works'),
    OnBoardingModel(
        image: 'assets/images/on_boarding_image_3.png',
        title: 'Get Notification',
        body: 'You Will Get Regular Notification Before Time Of work'),
  ];

  bool isLastPageView = false;
  bool checkIsLastPageView({
    required int index,
  }) {
    if (index == onBoardingItem.length - 1) {
      isLastPageView = true;
    } else {
      isLastPageView = false;
    }
    emit(OnBoardingState());
    return isLastPageView;
  }

  void finishPageView({
    required BuildContext context,
    required PageController controller,
  }) {
    if (isLastPageView) {
      CacheHelper.saveData(key: 'onBoardingStatus', value: true).then((value) {
        if (value) {
          navigateAndTerminateLast(
            context: context,
            widget: const HomeLayoutScreen(),
          );
        }
      });
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Widget checkStartScreen() {
    bool? onBoardingView = CacheHelper.getData(key: 'onBoardingStatus');
    if (onBoardingView == null) {
      return OnBoardingScreen();
    } else {
      return const HomeLayoutScreen();
    }
  }
}
