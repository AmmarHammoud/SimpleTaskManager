import 'package:flutter_test/flutter_test.dart';
import 'package:maidscc_test/database/database_service.dart';
import 'package:maidscc_test/models/task_model.dart';
import 'package:maidscc_test/shared/constants.dart';
import 'package:maidscc_test/shared/dio_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async{
  DioHelper.init();

  group('login test', () {
    test('given username and password when they are correct then success',
        () async {
      var response =
          await DioHelper.login(userName: 'emilys', password: 'emilyspass');
      expect(response.data['username'], 'emilys');
    });

    test('given username when it is NOT correct then fail', () async {
      var response =
          await DioHelper.login(userName: '-', password: 'emilyspass');
      expect(response.data['message'], 'Invalid credentials');
    });

    test('given password when it is NOT correct then fail', () async {
      var response = await DioHelper.login(userName: 'emilys', password: '-');
      expect(response.data['message'], 'Invalid credentials');
    });

    test('given user name and password when they are NOT correct then fail',
        () async {
      var response = await DioHelper.login(userName: '-', password: '-');
      expect(response.data['message'], 'Invalid credentials');
    });
  });

}
