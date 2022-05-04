import 'package:flutter/material.dart';
import 'package:uni/view/Pages/unieats_nodrawer_page_view.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Widgets/unieats_mini_restaurant_card.dart'; //mudar para importar mini restaurant card <- image, dist, name...

import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FavouritesPageView extends StatefulWidget {
  FavouritesPageView({
    Key key,
    @required this.favoriteRestaurants,
  });
  final List<Restaurant> favoriteRestaurants;

  @override
  State<StatefulWidget> createState() =>
      FavouritesPageViewState(favoriteRestaurants: favoriteRestaurants);
}

/// Manages the 'about' section of the app.
class FavouritesPageViewState extends UniEatsNoDrawerPageView {
  FavouritesPageViewState({
    Key key,
    @required this.favoriteRestaurants,
  });
  final List<Restaurant> favoriteRestaurants;

  @override
  Widget getBody(BuildContext context) {
    return StoreConnector<AppState, List<Restaurant>>(
      converter: (store) => (store.state.content['favoriteRestaurants']),
      builder: (context, restaurants) {
        return ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                'Favoritos',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .apply(fontSizeFactor: 1.3),
              ),
            ),
            Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: restaurantsFavourites(context, favoriteRestaurants),
            )),
          ],
        );
      },
    );
  }

  ///Returns a list of the restaurants to appear in the user favourites
  List<Widget> restaurantsFavourites(
      BuildContext context, List<Restaurant> restaurants) {
    List<Widget> favorites = <Widget>[];

    if (restaurants != null) {
      for (int i = 0; i < restaurants.length; i++) {
        favorites.add(UniEatsMiniRestaurantCard(
            restaurants[i], DateFormat('EEEE').format(DateTime.now())));
      }
    }

    return favorites;
  }
}
