import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_test/screens/login_screen/cubit/cubit.dart';
import 'package:maidscc_test/screens/login_screen/cubit/states.dart';
import 'package:maidscc_test/shared/components.dart';

//import 'package:flutter/foundation.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var login = LoginCubit.get(context);
            bool passwordIsShown = login.passwordIsShown;
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Login'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ValidatedTextField(
                          controller: login.userNameController,
                          icon: Icons.person,
                          validator: login.userNameValidator,
                          errorText: 'user name field cannot be empty',
                          hintText: 'user name',
                          onChanged: (String userName) => null),
                      const SizedBox(
                        height: 10,
                      ),
                      ValidatedTextField(
                          controller:
                              login.passwordController,
                          icon: Icons.lock,
                          hasNextText: false,
                          obscureText: passwordIsShown,
                          validator: login.passwordValidator,
                          errorText: 'password is incorrect',
                          hintText: 'password',
                          onChanged: (String password) => null,
                          suffixIcon: showPasswordIcon(
                              onPressed: () {
                                login.changePasswordVisibility();
                              },
                              passwordIsShown: passwordIsShown)),
                      const SizedBox(
                        height: 10,
                      ),
                      ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => ElevatedButton(
                              child: const Text('login'),
                              onPressed: () {
                                login.login(
                                    context: context,
                                    userName: login.userNameController.text,
                                    password: login.passwordController.text);
                              }),
                          fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
