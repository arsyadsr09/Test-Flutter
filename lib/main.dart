import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:toffin_app/redux/app_state.dart';
import 'package:toffin_app/redux/store.dart';
import 'package:toffin_app/routes.dart';
import 'package:toffin_app/screens/home/home.dart';

Future main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  Store<AppState> _store = await createStore();
  runApp(MainApp(store: _store));
}

class MainApp extends StatelessWidget {
  final Store<AppState> store;

  MainApp({this.store});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF2F3542),
        systemNavigationBarIconBrightness: Brightness.light));
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Toffin App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              // platform: TargetPlatform.iOS,
              iconTheme: IconThemeData(
                color: Color(0xFF2F3542),
              ),
              primarySwatch: Colors.grey,
              primaryTextTheme:
                  TextTheme(title: TextStyle(color: Color(0xFF2f3542)))),
          home: Home(),
          routes: routes,
        ));
  }
}
