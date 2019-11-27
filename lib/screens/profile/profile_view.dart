import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toffin_app/screens/widgets/form_text.dart';
import 'package:toffin_app/screens/widgets/select_suggestion.dart';

import 'profile_view_model.dart';

class ProfileView extends ProfileViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF2F3542),
        systemNavigationBarIconBrightness: Brightness.light));
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Color(0xFFFAFAFA),
              title: Text("Profile",
                  style: TextStyle(
                      fontFamily: "SFP_Text", fontWeight: FontWeight.bold)),
            )
          ];
        },
        body: Container(
          width: screenSize.width,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15),
                  Stack(
                    children: <Widget>[
                      image != null
                          ? SizedBox(
                              height: 140,
                              width: 140,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.file(image)))
                          : SizedBox(
                              height: 120,
                              width: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.asset("assets/placeholder.png")),
                            ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Container(
                          height: 35,
                          width: 35,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => imageSelect(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Color(0xFF747d8c),
                            textColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  SelectSuggestion(
                    hint: "Name employee",
                    controller: searchController,
                    getSuggestions: getSuggestion,
                    selectedSuggestion: selectedSuggestion,
                  ),
                  SizedBox(height: 15),
                  FormText(
                    controller: nameController,
                    label: "Name",
                    hint: 'Your full name',
                    onChange: onChange,
                  ),
                  nameError != ''
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text(
                            "$nameError",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontFamily: "SFP_Text",
                                fontSize: 12,
                                color: Colors.red),
                          ))
                      : SizedBox(),
                  FormText(
                    controller: ageController,
                    label: "Age",
                    hint: 'Your age',
                    onChange: onChange,
                  ),
                  ageError != ''
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text(
                            "$ageError",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontFamily: "SFP_Text",
                                fontSize: 12,
                                color: Colors.red),
                          ))
                      : SizedBox(),
                  FormText(
                    controller: salaryController,
                    label: "Salary",
                    hint: 'Your salary',
                    onChange: onChange,
                  ),
                  salaryError != ''
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Text(
                            "$salaryError",
                            style: TextStyle(
                                letterSpacing: 1,
                                fontFamily: "SFP_Text",
                                fontSize: 12,
                                color: Colors.red),
                          ))
                      : SizedBox(),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () => !isLoadingUpdate
                              ? onBtnUpdatePressed(item['id'])
                              : {},
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          color: item != Map()
                              ? Color(0xFF2ed573)
                              : Color(0xFF55cf87),
                          textColor: Colors.white,
                          child: isLoadingUpdate
                              ? Center(
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator()))
                              : Text(
                                  "Update",
                                  style: TextStyle(
                                      fontFamily: "SFP_Text",
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () => !isLoadingDelete
                              ? onBtnDeletePressed(item['id'])
                              : {},
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          color: item != Map()
                              ? Color(0xFFff4757)
                              : Color(0xFFfc9099),
                          textColor: Colors.white,
                          child: isLoadingDelete
                              ? Center(
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator()))
                              : Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontFamily: "SFP_Text",
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
