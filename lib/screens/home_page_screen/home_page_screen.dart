import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_test/screens/home_page_screen/cubit/cubit.dart';
import 'package:maidscc_test/screens/home_page_screen/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocConsumer<HomePageCubit, HomePageScreenStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text('Task Manager App'),
                ),
              )),
    );
  }
}
