import 'package:dio/dio.dart';

//192.168.52.17
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> login(
      {required String userName, required String password}) async {
    return await dio.post(
      'auth/login',
      data: {'username': userName, 'password': password},
      options: Options(
        headers: {'Accept': 'application/json'},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  static Future<Response> fetchAllTasks() async {
    return await dio.get('todos');
  }
}
