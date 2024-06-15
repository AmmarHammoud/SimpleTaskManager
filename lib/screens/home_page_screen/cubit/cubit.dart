import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_test/models/task_model.dart';
import 'package:maidscc_test/screens/home_page_screen/cubit/states.dart';
import 'package:maidscc_test/shared/dio_helper.dart';

class HomePageCubit extends Cubit<HomePageScreenStates> {
  HomePageCubit() : super(HomePageScreenInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  List<Todo> tasks = [];

  //Icon iconTaskState = const Icon(Icons.square_outlined);

  // initDatabase() {
  //   emit(HomePageScreenLoadingState());
  //   MyDatabase.open().then((value) {
  //     print(value);
  //     emit(HomePageScreenSuccessState());
  //   }).onError((error, stackTrace) {
  //     print(error.toString());
  //     emit(HomePageScreenErrorState());
  //   });
  // }

  ///fetch the tasks using the API
  fetchAllTasksAPI() {
    emit(HomePageScreenLoadingState());
    DioHelper.fetchAllTasks().then((value) {
      ///loop on the list to fill it according to [value.data]

      ///then emit
      emit(HomePageScreenSuccessState());
    }).onError((error, stackTrace) {});
  }

  ///fetch the tasks using local database
  fetchAllTasks() {
    emit(HomePageScreenLoadingState());
    tasks.clear();
    MyDatabase.fetchAll().then((value) {
      for (int i = 0; i < value.length; i++) {
        tasks.add(
            Todo(id: value[i].id, title: value[i].title, done: value[i].done));
      }
      print('tasks: $tasks');
      emit(HomePageScreenSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(HomePageScreenErrorState());
    });
  }

  ///the rest of the required methods follow the same logic

  addTask(Todo todo) {
    emit(HomePageScreenLoadingState());
    MyDatabase.insert(todo).then((value) {
      fetchAllTasks();
      emit(HomePageScreenSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(HomePageScreenErrorState());
    });
  }

  changeTaskState(Todo todo) {
    emit(HomePageScreenLoadingState());
    todo.done = !todo.done;
    MyDatabase.update(todo).then((value1) async {
      ///the task has been updated successfully
      print(value1);
      print(await MyDatabase.db.rawQuery('''SELECT * FROM todo'''));
      fetchAllTasks();
      emit(HomePageScreenSuccessState());
    }).onError((error, stackTrace) {
      emit(HomePageScreenErrorState());
    });
  }

  deleteTask(int id) {
    emit(HomePageScreenLoadingState());
    MyDatabase.delete(id).then((value) {
      print(value);
      fetchAllTasks();
      emit(HomePageScreenSuccessState());
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(HomePageScreenErrorState());
    });
  }

  editTask(Todo todo) {
    emit(HomePageScreenLoadingState());
    MyDatabase.update(todo).then((value) {
      fetchAllTasks();
      emit(HomePageScreenSuccessState());
    }).onError((error, stackTrace) {
      emit(HomePageScreenErrorState());
    });
  }
}
