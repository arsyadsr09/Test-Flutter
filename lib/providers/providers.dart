import 'package:dio/dio.dart';
import 'package:toffin_app/config/config.dart';

class Providers {
  static Future createUser({String name, String age, String salary}) async {
    return Dio().post('$HOST/create', data: {
      "name": name,
      "age": age,
      "salary": salary,
    });
  }

  static Future getUsers() async {
    return Dio().get('$HOST/employees');
  }

  static Future getUserById({String id}) async {
    return Dio().get('$HOST/employee/$id');
  }

  static Future deleteUser({String id}) async {
    return Dio().delete('$HOST/delete/$id');
  }

  static Future updateUser(
      {String id, String name, String age, String salary}) async {
    return Dio().put('$HOST/update/$id', data: {
      "name": name,
      "age": age,
      "salary": salary,
    });
  }
}
