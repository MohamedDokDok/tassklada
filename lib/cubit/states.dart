abstract class AppStates{}

class AppInitState extends AppStates{}

class ChangeThemeMode extends AppStates{}

class ChangeSelectedColor extends AppStates{}

class CreateDataBaseSuccessState extends AppStates{}

// insert data into database
class InsertDataIntoDataBaseLoadingState extends AppStates{}

class InsertDataIntoDataBaseSuccessState extends AppStates{}

// to get data from data base
class AppGetDataFromDataBaseLoadingState extends AppStates{}

class AppGetDataFromDataBaseSuccessState extends AppStates{}

// to update data into data base
class UpdateDataIntoDataBaseLoadingState extends AppStates{}

class UpdateDataIntoDataBaseSuccessState extends AppStates{}


// to delete data into data base
class DeleteDataFromDataBaseLoadingState extends AppStates{}

class DeleteDataFromDataBaseSuccessState extends AppStates{}

class ChangeSelectedDateState extends AppStates{}

class ChangeIndexOfBottomNavBarState extends AppStates{}

class GetTasksPerSelectedDateSuccessState extends AppStates{}

class OnBoardingState extends AppStates{}


