
import '../local_data_base/abstract_data_base_model.dart';

class TaskModel implements DatabaseModel{

  late int? taskID;
  late String title;
  late String note;
  late String date;
  late String startTime;
  late String endTime;
  late String remind;
  late String repeat;
  late int color;
  late int isComplete;


  TaskModel();

  TaskModel.data({
    this.taskID,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this. remind,
    required this.repeat,
    required this.color,
    required this.isComplete,
});


  TaskModel.fromJson(Map<String, dynamic> map){
    taskID =map['id'];
    title =map['title'];
    note =map['note'];
    date =map['date'];
    startTime =map['startTime'];
    endTime =map['endTime'];
    remind =map['remind'];
    repeat =map['repeat'];
    color =map['color'];
    isComplete =map['isComplete'];
  }

  @override
  int getID() {
    return taskID!;
  }

  @override
  String tableName() {
   return 'tasks';
  }

  @override
  Map<String, dynamic> toJson() {
    return{
      'id' : taskID,
      'title' : title,
      'note' : note,
      'date' : date,
      'startTime' : startTime,
      'endTime' : endTime,
      'remind' : remind,
      'repeat' :repeat,
      'color' :color,
      'isComplete' : isComplete,
    };
  }


}