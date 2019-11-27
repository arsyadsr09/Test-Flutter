import 'package:flutter/material.dart';
import 'package:toffin_app/screens/all_employees/all_employees.dart';
import 'package:toffin_app/screens/create_new_employee/create_new_employee.dart';
import 'package:toffin_app/screens/home/home.dart';
import 'package:toffin_app/screens/profile/profile.dart';

final Map<String, WidgetBuilder> routes = {
  '/Home': (BuildContext context) => Home(),
  '/Profile': (BuildContext context) => Profile(),
  '/AllEmployees': (BuildContext context) => AllEmployees(),
  '/CreateNewEmployee': (BuildContext context) => CreateNewEmployee(),
};
