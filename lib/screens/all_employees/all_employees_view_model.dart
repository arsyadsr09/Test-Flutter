import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'package:toffin_app/providers/providers.dart';
import 'package:toffin_app/redux/actions/main_action.dart';
import 'package:toffin_app/redux/app_state.dart';

import 'all_employees.dart';

abstract class AllEmployeesViewModel extends State<AllEmployees> {
  Store<AppState> store;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Map> items = [
    {'name': "Agung Soarla", 'age': 29, 'salary': 2000000000},
    {'name': "Agung as", 'age': 239, 'salary': 2000000000},
    {'name': "Agung asd", 'age': 49, 'salary': 2000000000},
    {'name': "Agung asd", 'age': 249, 'salary': 2000000000},
  ];

  Future initUsers() async {
    Providers.getUsers().then((res) {
      print(json.decode(res.data));
      store.dispatch(SetUsers(users: List.from(json.decode(res.data))));
    }).catchError((err) => print(err.toString()));
  }

  void onRefresh() async {
    // monitor network fetch
    await initUsers();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
