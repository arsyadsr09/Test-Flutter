import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:toast/toast.dart';
import 'package:toffin_app/providers/providers.dart';
import 'package:toffin_app/redux/actions/main_action.dart';
import 'package:toffin_app/redux/app_state.dart';
import 'profile.dart';

abstract class ProfileViewModel extends State<Profile> {
  Store<AppState> store;
  var mainState;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  MoneyMaskedTextController salaryController =
      MoneyMaskedTextController(precision: 3, leftSymbol: 'Rp. ');

  bool isLoadingUpdate = false;
  bool isLoadingDelete = false;
  String nameError = '';
  String ageError = '';
  String salaryError = '';
  Map item = Map();

  void toggleLoadingUpdate(value) {
    setState(() {
      isLoadingUpdate = value;
    });
  }

  void toggleLoadingDelete(value) {
    setState(() {
      isLoadingDelete = value;
    });
  }

  File image;
  String imageUrl;

  void imageSelect(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (BuildContext context) {
          return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          await getImage(1);
                          await cropImage();
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: RaisedButton(
                              color: Color(0xFF282828),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                await getImage(1);
                                await cropImage();
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text("Select from Camera"),
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () async {
                          await getImage(0);
                          await cropImage();
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: RaisedButton(
                              color: Color(0xFF282828),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                await getImage(0);
                                await cropImage();
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.photo_library,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text("Select from Gallery"),
                        ),
                      ),
                    ],
                  )));
        });
  }

  Future getImage(int type) async {
    try {
      var _image = await ImagePicker.pickImage(
          source: type == 0 ? ImageSource.gallery : ImageSource.camera);

      setState(() {
        image = _image;
      });
    } catch (err) {
      print(err);
    }
  }

  Future<Null> cropImage() async {
    try {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        maxWidth: 512,
        maxHeight: 512,
      );

      setState(() {
        image = croppedFile;
      });
    } catch (err) {
      print(err);
    }
  }

  List getSuggestion(String query) {
    List matches = List();
    matches.addAll(mainState.users);

    matches.retainWhere(
        (s) => s['employee_name'].toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  void selectedSuggestion(_item) {
    setState(() {
      nameController.text = _item['employee_name'];
      ageController.text = _item['employee_age'].toString();
      salaryController.updateValue(double.parse(_item['employee_salary']));
      item = _item;
    });
  }

  void onChange(text) {
    setState(() {
      nameError = "";
      ageError = "";
      salaryError = "";
    });
  }

  void initUsers() {
    Providers.getUsers().then((res) {
      print(json.decode(res.data));
      store.dispatch(SetUsers(users: List.from(json.decode(res.data))));
    }).catchError((err) => print(err.toString()));
  }

  void toastMsg(String message) {
    Toast.show("$message", context,
        backgroundColor: Color(0xFF747d8c),
        textColor: Colors.white,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM);
  }

  void onBtnUpdatePressed(String id) {
    if (nameController.text.length <= 0) {
      setState(() {
        nameError = 'Textfield name can\'t be null';
      });
    } else if (ageController.text.length <= 0) {
      setState(() {
        ageError = 'Textfield age can\'t be null';
      });
    } else if (nameController.text.length <= 0) {
      setState(() {
        salaryError = 'Textfield salary can\'t be null';
      });
    } else {
      if (this.mounted) {
        toggleLoadingUpdate(true);
      }
      Providers.updateUser(
              id: id,
              name: nameController.text,
              age: ageController.text,
              salary: salaryController.numberValue.toString())
          .then((res) {
        toastMsg('Employee Updated');
        initUsers();
        setState(() {
          nameController.clear();
          ageController.clear();
          salaryController.clear();
          searchController.clear();
        });
        if (this.mounted) {
          toggleLoadingUpdate(false);
        }
      }).catchError((err) => print(err.toString()));
    }
  }

  void onBtnDeletePressed(String id) {
    if (this.mounted) {
      toggleLoadingDelete(true);
    }
    Providers.deleteUser(id: id).then((res) {
      toastMsg('Employee Deleted');
      initUsers();
      setState(() {
        nameController.clear();
        ageController.clear();
        salaryController.clear();
        searchController.clear();
      });
      if (this.mounted) {
        toggleLoadingDelete(false);
      }
    }).catchError((err) => print(err.toString()));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      mainState = store.state.mainState;
    });
  }
}
