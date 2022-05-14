abstract class DatabaseModel{

  String tableName();

  int getID();

  Map<String, dynamic> toJson();

  DatabaseModel.fromMap(Map<String, dynamic> map);


}