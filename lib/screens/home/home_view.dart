import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toffin_app/helpers/navigation_animation.dart';
import 'package:toffin_app/screens/create_new_employee/create_new_employee.dart';
import 'home_view_model.dart';

class HomeView extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF2F3542),
        systemNavigationBarIconBrightness: Brightness.light));
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: children[currentIndex]['page'],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.transparent,
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          child: new BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: currentIndex,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            backgroundColor: Color(children[currentIndex]['background']),
            selectedItemColor: Color(children[currentIndex]['selectedColor']),
            unselectedItemColor:
                Color(children[currentIndex]['unSelectedColor']),
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.people, size: 35),
                title: Container(height: 0.0),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.settings, size: 35),
                title: Container(height: 0.0),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF79520),
          onPressed: () => Navigator.push(
              context, NavigationRoute(enterPage: CreateNewEmployee())),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
