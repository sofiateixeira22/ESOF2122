import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/view/Widgets/restaurant_card.dart';
import 'package:uni/view/Widgets/restaurant_row.dart';

class UniEatsHomePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UniEatsHomePageViewState();
}

/// Manages the 'about' section of the app.
class UniEatsHomePageViewState extends UniEatsGeneralPageViewState {
  @override
  Widget getBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: restaurants_homepage(context),
        )),
      ],
    );
  }

  ///Returns a list of the restaurants to appear in the unieats homepage
  List<Widget> restaurants_homepage(BuildContext context) {
    final List<Widget> restaurants = <Widget>[];

    restaurants.add(Row(children: [
      Expanded(
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 80,
            width: (double.maxFinite) / 2,
            child: Card(
              elevation: 5,
              child: (Center(
                child: Text('Favourites'),
              )),
            )),
      ),
      Expanded(
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 80,
            width: (double.maxFinite) / 2,
            child: Card(
              elevation: 5,
              child: (Center(
                child: Text('History'),
              )),
            )),
      )
    ]));

    //Está hardcoded para ter dummys
    //ter uma função para ir buscar restaurantes da base de dados
    for (int i = 0; i < 10; i++) {
      restaurants.add(Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 220,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: (Center(
              child: Text('Restaurant Placeholder'),
            )),
          )));
    }

    return restaurants;
  }
}
