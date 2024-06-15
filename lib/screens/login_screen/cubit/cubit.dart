import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_test/models/user_model.dart';
import 'package:maidscc_test/screens/home_page_screen/home_page_screen.dart';
import 'package:maidscc_test/screens/login_screen/cubit/states.dart';
import 'package:maidscc_test/shared/dio_helper.dart';

import '../../../shared/components.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool passwordIsShown = true;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> userNameValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordValidator = GlobalKey<FormState>();

  late UserModel userModel;

  changePasswordVisibility() {
    if (passwordIsShown) {
      passwordIsShown = false;
      emit(NotShownPassword());
    } else {
      passwordIsShown = true;
      emit(ShownPassword());
    }
  }

  login(
      {required context, required String userName, required String password}) {
    if(userNameValidator.currentState!.validate() && passwordValidator.currentState!.validate()){
      emit(LoginLoadingState());
      DioHelper.login(userName: userName, password: password).then((value) {
        print(value.data);

        ///invalid credentials
        if (value.data['message'] == 'Invalid credentials') {
          showToast(
              context: context, text: 'Invalid credentials', color: Colors.red);
        } else {
          ///fill [userModel] for later usage
          userModel = UserModel.fromJson(value.data);
          showToast(
              context: context, text: 'logged successfully', color: Colors.green);
          navigateAndFinish(context, HomePage());
        }
        emit(LoginSuccessState());
      }).onError((error, stackTrace) {
        print(error.toString());
        emit(LoginErrorState());
      });
    }
  }
}
