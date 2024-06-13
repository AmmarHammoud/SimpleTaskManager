
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maidscc_test/screens/home_page_screen/cubit/states.dart';

class HomePageCubit extends Cubit<HomePageScreenStates>{
  HomePageCubit () : super(HomePageScreenInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);
}