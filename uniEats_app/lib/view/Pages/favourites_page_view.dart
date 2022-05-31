import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uni/view/Pages/unieats_nodrawer_page_view.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Widgets/unieats_mini_restaurant_card.dart'; //mudar para importar mini restaurant card <- image, dist, name...

import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
  final CollectionReference _collectionFav = FirebaseFirestore.instance.collection('favorites');

  Future<List> getFavorites(context) async {
    QuerySnapshot querySnapshot = await _collectionFav.get();
    final favoritesAll = querySnapshot.docs.map((doc) => doc.data()).toList();
    var userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);
    print("[GET_FAV]");
    for(var i = 0; i < favoritesAll.length; i++){
      var studentID = (jsonDecode(jsonEncode(favoritesAll[i]))['studentID']);
      if(studentID == userID){
        print((jsonDecode(jsonEncode(favoritesAll[i]))['restaurtsName']));
        return((jsonDecode(jsonEncode(favoritesAll[i]))['restaurtsName']));
      }
        
    }
    return null;
  
  }

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
              children: restaurantsFavourites(context, restaurants),
            )),
          ],
        );
      },
    );
  }

  ///Returns a list of the restaurants to appear in the user favourites
 /* List<Widget> restaurantsFavourites(
    BuildContext context) {
    List<Widget> favorites = <Widget>[];
    List<Restaurant> allRest = (StoreProvider.of<AppState>(context).state.content['restaurants']);
    final Future<List> favsName = getFavorites(context);
    if (allRest != null && favsName !=null) {
      for (int i = 0; i < allRest.length; i++) {
       // var name = allRest[i].toMap()["name"];
        //if(name == favsName[0]){
         // print("[REST_FAVS");
          //print(name);
          favorites.add(UniEatsMiniRestaurantCard(
            allRest[i], DateFormat('EEEE').format(DateTime.now())));
        //}
        
      }
    }

    return favorites;
  }*/

  List<Widget> restaurantsFavourites(
      BuildContext context, List<Restaurant> restaurants) {
    List<Widget> favorites = <Widget>[];
    final Future<List> favsName = getFavorites(context);


    if (restaurants != null) {
      for (int i = 0; i < favorites.length; i++) {
        favorites.add(UniEatsMiniRestaurantCard(
            restaurants[i], DateFormat('EEEE').format(DateTime.now())));
      }
    }

    return favorites;
  }
}
