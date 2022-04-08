import 'package:flutter/material.dart';
import 'package:uni/view/Pages/unieats_nodrawer_page_view.dart';

class FavouritesPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavouritesPageViewState();
}

/// Manages the 'about' section of the app.
class FavouritesPageViewState extends UniEatsNoDrawerPageView {
  @override
  Widget getBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
          child: Text(
            'Favourites',
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(fontSizeFactor: 1.3),
          ),
        ),
        Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: restaurantsFavourites(context),
        )),
      ],
    );
  }

  ///Returns a list of the restaurants to appear in the user favourites
  List<Widget> restaurantsFavourites(BuildContext context) {
    final List<Widget> restaurants = <Widget>[];

    //Está hardcoded para ter dummys
    //ter uma função para ir buscar restaurantes favoritos da base de dados
    for (int i = 0; i < 3; i++) {
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
