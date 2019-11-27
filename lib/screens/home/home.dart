import 'package:flutter/material.dart';
import 'home_view.dart';

class Home extends StatefulWidget {
  final int index;

  Home({this.index});

  @override
  HomeView createState() => new HomeView();
}
