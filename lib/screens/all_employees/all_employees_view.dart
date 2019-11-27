import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toffin_app/redux/app_state.dart';
import 'package:toffin_app/redux/modules/main_state.dart';

import 'all_employees_view_model.dart';

class AllEmployeesView extends AllEmployeesViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF2F3542),
        systemNavigationBarIconBrightness: Brightness.light));
    final screenSize = MediaQuery.of(context).size;
    final currency = new NumberFormat("#,##0.00", "en_US");

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Color(0xFFFAFAFA),
              title: Text("All Employees",
                  style: TextStyle(
                      fontFamily: "SFP_Text", fontWeight: FontWeight.bold)),
            )
          ];
        },
        body: Container(
            width: screenSize.width,
            child: SmartRefresher(
              enablePullDown: true,
              header: WaterDropMaterialHeader(
                color: Colors.white,
                backgroundColor: Color(0xFFF79520),
              ),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              controller: refreshController,
              onRefresh: onRefresh,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 15),
                  StoreConnector<AppState, MainState>(
                      converter: (store) => store.state.mainState,
                      builder: (ctx, state) {
                        return state.users.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, i) {
                                  return Card(
                                    elevation: 0,
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          'assets/placeholder.png',
                                        ),
                                      ),
                                      title: Text(
                                          "${state.users[i]['employee_name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Text(
                                              "Age: ${state.users[i]['employee_age']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(width: 20),
                                          Text(
                                              "Salary: ${currency.format(int.parse(state.users[i]['employee_salary']))}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: state.users.length,
                              )
                            : Container(
                                width: screenSize.width,
                                height: screenSize.height / 1.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                        height: 100,
                                        child: SvgPicture.asset(
                                            'assets/data_not_found.svg',
                                            semanticsLabel: 'data_not_found')),
                                    SizedBox(height: 15),
                                    Text('No data found',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF2F3542),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "SFP_Text")),
                                  ],
                                ),
                              );
                      })
                ],
              ),
            )),
      ),
    );
  }
}
