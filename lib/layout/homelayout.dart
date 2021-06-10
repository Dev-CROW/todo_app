import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is InsertToDBState) {
            Navigator.of(context).pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                "${cubit.titles[cubit.currentIndex]}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! DBLoading,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertDB(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                  }
                } else
                {
                  scaffoldKey.currentState
                      .showBottomSheet((context) => Container(
                    padding: EdgeInsets.all(20.0),
                    color: Colors.grey[100],
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormfield(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Title Must Not Be Empty';
                                }
                                return null;
                              },
                              textlabel: 'Title ',
                              prefix: Icons.title),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormfield(
                            controller: timeController,
                            type: TextInputType.datetime,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Time Must Not Be Empty';
                              }
                              return null;
                            },
                            textlabel: 'Time Task',
                            prefix: Icons.watch,
                            onTapped: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeController.text =
                                    value.format(context).toString();
                              });
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormfield(
                            controller: dateController,
                            type: TextInputType.datetime,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Date Must Not Be Empty';
                              }
                              return null;
                            },
                            textlabel: 'Date Task',
                            prefix: Icons.calendar_today,
                            onTapped: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-12-30'),
                              ).then((value) => dateController.text =
                                  DateFormat.yMMMd().format(value));
                            },
                          )
                        ],
                      ),
                    ),
                  ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(icon: Icons.edit, isShow: false);
                  });
                  cubit.changeBottomSheet(icon: Icons.add, isShow: true);
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
              selectedItemColor: Colors.blueGrey,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "New Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: "Done Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archived Tasks",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
