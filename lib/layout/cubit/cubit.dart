import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/module/archive_tasks_screen.dart';
import 'package:todo_app/module/done_tasks_screen.dart';
import 'package:todo_app/module/new_tasks_screen.dart';
import 'package:todo_app/shared/network/local/cache/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<String> titles = [
    "NewTasks",
    "DoneTasks",
    "ArchiveTasks",
  ];
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchiveTasksScreen()
  ];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  int currentIndex = 0;

  void changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;

  void changeBottomSheet({@required IconData icon, @required bool isShow}) {
    fabIcon = icon;
    isBottomSheetShown = isShow;
    emit(ChangeBottomSheetState());
  }

  Database database;

  void createDB() async {
    await openDatabase("tasks.db", version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT, time TEXT ,status TEXT)')
          .then((value) => print("DB Created"));
    }, onOpen: (database) {
      print("DB Opened");
    }).then((value) {
      database = value;
      emit(CreateDBState());
      getDataFromDB(database);
    });
  }

  getDataFromDB(database) async {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(DBLoading());

    database.rawQuery('SELECT * FROM tasks').then(
      (value) {
        value.forEach((element) {
          if (element['status'] == 'new') newTasks.add(element);
          if (element['status'] == 'done') doneTasks.add(element);
          if (element['status'] == 'archive') archiveTasks.add(element);
        });
        emit(GetDataFDBState());
      },
    );
  }

  insertDB({
    @required String title,
    @required String date,
    @required String time,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date , time ,status) VALUES ("$title", "$date" , "$time" ,"new")')
          .then((value) {
        print("$value inserted Successfully");

        getDataFromDB(database);
        emit(InsertToDBState());
      });
      return null;
    });
  }

  updateData({
    @required String status,
    @required int id,
  }) async {
    await database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDB(database);
      emit(UpdateDBState());
    });
  }

  // void deleteData({
  //   @required int id,
  // }) async
  // {
  //  await database.rawDelete('DELETE FROM tasks WHERE id = ?' , [id],).then((value)
  //   {
  //     getDataFromDB(database);
  //     emit(DeleteDBState());
  //   });
  // }

  deleteData({
    @required int id,
  }) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDB(database);
      emit(DeleteDBState());
    });
  }

  bool isDark = false;

  void changeAppMode({bool fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(ChangeThemeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }
}
