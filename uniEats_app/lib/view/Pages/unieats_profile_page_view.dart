import 'dart:io';
import 'package:uni/controller/load_info.dart';
import 'package:uni/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/view/Pages/unieats_nodrawer_page_view.dart';
import 'package:uni/view/Widgets/unieats_favs_card.dart';
import 'package:uni/view/Widgets/unieats_history_card.dart';
import 'package:uni/view/Widgets/unieats_mini_restaurant_card.dart';
import 'package:uni/view/Widgets/unieats_stats_card.dart';

import '../../model/entities/restaurant.dart';

class UniEatsProfilePageView extends StatefulWidget {
  final String name;
  final String email;
  UniEatsProfilePageView(
      {Key key,
      @required this.name,
      @required this.email});
  @override
  State<StatefulWidget> createState() => UniEatsProfilePageViewState(
      name: name, email: email);
}

/// Manages the 'Personal user page' section.
class UniEatsProfilePageViewState extends UniEatsNoDrawerPageView {
  UniEatsProfilePageViewState(
      {Key key,
      @required this.name,
      @required this.email});
  final String name;
  final String email;

  @override
  Widget getBody(BuildContext context) {
    return ListView(shrinkWrap: false, children: childrenList(context));
  }

  @override
  Widget getTopRightButton(BuildContext context) {
    return Container();
  }

  /// Returns a list with all the children widgets of this page.
  List<Widget> childrenList(BuildContext context) {
    final List<Widget> list = [];
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(profileInfo(context));
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(UniEatsStatsCard());
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(UniEatsFavoritesCard());
    list.add(Padding(padding: const EdgeInsets.all(5.0)));
    list.add(UniEatsHistoryCard());
    return list;
  }

  /// Returns a widget with the user's profile info (Picture, name and email).
  Widget profileInfo(BuildContext context) {
    final String number = email.split('@')[0];

    return StoreConnector<AppState, Future<File>>(
      converter: (store) => loadProfilePic(store),
      builder: (context, profilePicFile) => FutureBuilder(
        future: profilePicFile,
        builder: (BuildContext context, AsyncSnapshot<File> profilePic) =>
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: getDecorageImage(profilePic.data))),
            Padding(padding: const EdgeInsets.all(8.0)),
            Text(name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
            Padding(padding: const EdgeInsets.all(5.0)),
            Text(number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
