import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/view/Pages/unieats_profile_page_view.dart';
import 'dart:io';

import 'entities/course.dart';

class UniEatsProfilePage extends StatefulWidget {
  @override
  _UniEatsProfilePageState createState() => _UniEatsProfilePageState();

  //Handle arguments from parent
  UniEatsProfilePage({Key key}) : super(key: key);
}

class _UniEatsProfilePageState extends State<UniEatsProfilePage> {
  String name;
  String email;
  Map<String, String> currentState;
  List<Course> courses;
  Future<File> profilePicFile;

  @override
  void initState() {
    super.initState();
    name = '';
    email = '';
    currentState = {};
    courses = [];
    profilePicFile = null;
  }

  @override
  Widget build(BuildContext context) {
    updateInfo();
    return UniEatsProfilePageView(
        name: name, email: email, currentState: currentState, courses: courses);
  }

  void updateInfo() async {
    setState(() {
      if (StoreProvider.of<AppState>(context).state.content['profile'] !=
          null) {
        name =
            StoreProvider.of<AppState>(context).state.content['profile'].name;
        email =
            StoreProvider.of<AppState>(context).state.content['profile'].email;
        currentState =
            StoreProvider.of<AppState>(context).state.content['coursesStates'];
        courses = StoreProvider.of<AppState>(context)
            .state
            .content['profile']
            .courses;
      }
    });
  }
}
