import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:toffin_app/providers/providers.dart';
import 'package:toffin_app/redux/actions/main_action.dart';
import 'package:toffin_app/redux/app_state.dart';
import 'package:toffin_app/screens/all_employees/all_employees.dart';
import 'package:toffin_app/screens/profile/profile.dart';
import 'home.dart';

abstract class HomeViewModel extends State<Home> {
  Store<AppState> store;
  int currentIndex = 0;
  List<Map> children = [
    {
      "name": "All Employees",
      "page": AllEmployees(),
      "unSelectedColor": 0xFFa4b0be,
      "selectedColor": 0xFFF79520,
      "background": 0xFF2F3542
    },
    {
      "name": "Profile",
      "page": Profile(),
      "unSelectedColor": 0xFFa4b0be,
      "selectedColor": 0xFFF79520,
      "background": 0xFF2F3542
    }
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void initUsers() {
    Providers.getUsers().then((res) {
      print(json.decode(res.data));
      store.dispatch(SetUsers(users: List.from(json.decode(res.data))));
    }).catchError((err) => print(err.toString()));
  }

  @override
  void initState() {
    currentIndex = this.widget.index ?? 0;
    initUsers();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
    });
  }
}
