import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:uni/view/Pages/unieats_nodrawer_page_view.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Widgets/unieats_mini_restaurant_card.dart'; //mudar para importar mini restaurant card <- image, dist, name...

import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../Widgets/request_dependent_widget_builder.dart';

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
  final CollectionReference _collectionFav = FirebaseFirestore.instance.collection('favorites');
  bool loading = false;
  final List<Restaurant> favoriteRestaurants;
  var restNames;
  BuildContext context;
  var userID;


  Widget getContent(Context){
    return loading
        ? Center(child: Text('Loading...'))
        : Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                'Favoritos',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .apply(fontSizeFactor: 1.3),
              ),
            );
  }

  fetchFavs() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await _collectionFav.get();
    final favorites_all = querySnapshot.docs.map((doc) => doc.data()).toList();
    var userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);
    var user_favorites = [];
    print("[GET_FAV2]");
    for(var i = 0; i < favorites_all.length; i++){
      var studentID = (jsonDecode(jsonEncode(favorites_all[i]))['studentID']);
      if(studentID == userID){
        restNames = ((jsonDecode(jsonEncode(favorites_all[i]))['restaurtsName']));
      }
        
    }
    setState(() {
      loading = false;
    });
    print("END OF FETCH");
  }

  @override
  Widget getBody(BuildContext context) {
    userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);
    this.context = context;
    fetchFavs();
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



  List<Widget> restaurantsFavourites( BuildContext context, List<Restaurant> restaurants) {
    List<Widget> favorites = <Widget>[];
    List<Restaurant> all_rest =  StoreProvider.of<AppState>(context).state.content['restaurants'];
    //final Future<List> favsName = getFavorites(context);

    if (restNames != null) {
      print("[MiniCard Object]");
      print(restNames.length);
      for (int i = 0; i < all_rest.length; i++) {
        for(int j = 0; j< restNames.length; j++){
          if(restNames[j]== all_rest[i].name){
            print("Found");
            favorites.add(Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 110,
                width: double.maxFinite,
                child: Card(
                  elevation: 5,
                  child: (Center(
                    child: Text(restNames[j]),
                  )),
                )));
          }
        }
      }
    }

    return favorites;
  }

 
}

    /*return ListView(
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
        );*/