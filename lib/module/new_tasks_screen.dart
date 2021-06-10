import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
 var tasks = AppCubit.get(context).newTasks;
    return BlocConsumer<AppCubit , AppStates>(
        listener: (context , state) {},
        builder: (context , state) { return tasksBuilder(tasks: tasks);}
    );
  }
}
