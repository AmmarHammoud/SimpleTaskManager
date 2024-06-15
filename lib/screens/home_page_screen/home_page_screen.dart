import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_test/models/task_model.dart';
import 'package:maidscc_test/screens/home_page_screen/cubit/cubit.dart';
import 'package:maidscc_test/screens/home_page_screen/cubit/states.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit()..fetchAllTasks(),
      child: BlocConsumer<HomePageCubit, HomePageScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = HomePageCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Task Manager App'),
              ),
              body: SingleChildScrollView(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        TaskItem(todo: cubit.tasks[index], cubit: cubit),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 1,
                        ),
                    itemCount: cubit.tasks.length),
              ),
              floatingActionButton: IconButton(
                  onPressed: () {
                    print('floating action button');
                    // SimpleDialog(
                    //   title: const Text('Please add a title'),
                    //   children: [
                    //     Column(
                    //       children: [
                    //         TextFormField(
                    //           controller: titleController,
                    //         ),
                    //         ElevatedButton(onPressed: (){
                    //           cubit.addTask(Todo(title: titleController.text));
                    //         }, child: const Text('OK'))
                    //       ],
                    //     )
                    //   ],
                    // );
                    bottomSheet(
                        titleController: titleController,
                        context: context,
                        text: 'please enter the title',
                        onPressed: () {
                          cubit.addTask(Todo(title: titleController.text));
                          Navigator.pop(context);
                        });
                    titleController.text = '';
                  },
                  icon: const Icon(Icons.add)),
            );
          }),
    );
  }
}

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.todo, required this.cubit});

  final Todo todo;
  final dynamic cubit;
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    cubit.changeTaskState(todo);
                  },
                  icon: todo.done
                      ? const Icon(
                          Icons.check_box,
                          color: Colors.green,
                        )
                      : const Icon(Icons.square_outlined)),
              Text(todo.title),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    titleController.text = todo.title;
                    bottomSheet(
                        titleController: titleController,
                        context: context,
                        text: 'edit the title',
                        onPressed: () {
                          cubit.editTask(Todo(
                              id: todo.id,
                              title: titleController.text,
                              done: todo.done));
                          Navigator.pop(context);
                        });
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    cubit.deleteTask(todo.id);
                  },
                  icon: const Icon(Icons.delete_forever_sharp)),
            ],
          ),
        ],
      ),
    );
  }
}

Widget bottomSheet(
    {required context,
    required String text,
    required TextEditingController titleController,
    required Function()? onPressed}) {
  //TextEditingController titleController = TextEditingController();
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Text(text),
                TextFormField(
                  controller: titleController,
                ),
                ElevatedButton(onPressed: onPressed, child: const Text('OK'))
              ],
            ),
          ),
        ),
      );
    },
  );
  return Container();
}
