// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:ffi';
//import 'dart:html';


import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Pages/restaurant_page_view.dart';
import 'package:uni/view/Widgets/meal_slot.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'date_rectangle.dart';
import 'generic_card.dart';
import 'package:intl/intl.dart';
import 'package:uni/utils/constants.dart' as Constants;

class UniEatsRestaurantCard extends GenericCard {
  Restaurant restaurant;
  String day;
  bool isHomepage;
  String title;

  final Stream<QuerySnapshot> restDB =
      FirebaseFirestore.instance.collection('restaurants').snapshots();

  UniEatsRestaurantCard(
    Restaurant restaurant,
    String day,
    String title,
    bool isHomepage, {
    Key key,
  })  : restaurant = restaurant,
        day = day,
        isHomepage = isHomepage,
        title = title,
        super(key: key);

  UniEatsRestaurantCard.fromEditingInformation(
      Key key, bool editingMode, Function onDelete)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  String getTitle() => this.title;

  @override
  onClick(BuildContext context) => Navigator.pushNamed(
        context,
        '/' + Constants.navRestaurant,
        arguments: this.restaurant,
      );

  @override
  Widget buildCardContent(BuildContext context) {
    final Tuple2<Restaurant, String> tuple = Tuple2(restaurant, day);
    return RequestDependentWidgetBuilder(
        context: context,
        contentGenerator: generateMeals,
        content: tuple,
        contentChecker: true,
        onNullContent: Center(
            child: Text('Não existem restaurantes para apresentar',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center)));
  }

  Widget generateMeals(tuple, context) {
    Restaurant restaurant = tuple.item1;
    String day = tuple.item2;
    DayOfWeek dayOfWeek;
    switch (day) {
      case 'Monday':
        dayOfWeek = DayOfWeek.monday;
        break;
      case 'Tuesday':
        dayOfWeek = DayOfWeek.tuesday;
        break;
      case 'Wednesday':
        dayOfWeek = DayOfWeek.wednesday;
        break;
      case 'Thursday':
        dayOfWeek = DayOfWeek.thursday;
        break;
      case 'Friday':
        dayOfWeek = DayOfWeek.friday;
        break;
      case 'Saturday':
        dayOfWeek = DayOfWeek.saturday;
        break;
      case 'Sunday':
        dayOfWeek = DayOfWeek.sunday;
        break;
      default:
        break;
    }
    List<Meal> meals = restaurant.getMealsOfDay(dayOfWeek);
    if(meals != null){
      return Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: getMealRows(context, meals),
      ));
    }
    return Container(
      child: Text("Não existem refeições para apresentar neste dia.\n Pressione para ver refeiçóes de outros dias"));

  }

  List<Widget> getMealRows(context, List<Meal> meals) {
    final List<Widget> rows = <Widget>[];
    bool click = false;

    var scheduleList;
    int priceRange;
    var coords;

    if (isHomepage) {
    rows.add(StreamBuilder(
        stream: restDB,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          final data = snapshot.requireData;

          for (int i = 0; i < data.size; i++) {
            if (data.docs[i]['name'] == 'Cantina - Almoço' &&
                restaurant.name == 'Cantina - Jantar') {
              priceRange = data.docs[i]['priceRange'];
              coords = data.docs[i]['coords'];
              continue;
            } else if (data.docs[i]['name'] == 'Cantina - Jantar' &&
                priceRange != null) {

              scheduleList = data.docs[i]['schedule'];
              break;
            } else if (data.docs[i]['name'] == restaurant.name) {

              priceRange = data.docs[i]['priceRange'];
              scheduleList = data.docs[i]['schedule'];
              coords = data.docs[i]['coords'];
              break;
            }
          }
          return Row(
        children: [
        Row(
          children: [
            Icon(Icons.pin_drop_outlined),
            Text((coords.latitude).toString() + ' - ' + (coords.longitude).toString(), style: TextStyle(fontSize: 9.0)), //for location to current place
          ],
        ),
        Spacer(),
        Row(children: [
          Icon(Icons.timer_outlined),
          Text(scheduleList[DateTime.now().weekday - 1]) //for timeopen
        ],),
        Spacer(),
        FavoriteWidget( restaurant: this.restaurant,),

      ]);
    }));
    }

    final now = DateTime.now();
    if (meals == null) {
      return rows;
    }
    for (int i = 0; i < meals.length; i++) {
      rows.add(createRowFromMeal(context, meals[i]));
    }

    return rows;
  }

  Widget createRowFromMeal(context, meal) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: MealSlot(
          type: meal.type,
          name: meal.name,
        ));
  }
}


class FavoriteWidget extends StatefulWidget {
  var restaurant;
  final CollectionReference _collectionFav = FirebaseFirestore.instance.collection('favorites');
  FavoriteWidget({
    Key key,
    @required this.restaurant,
  });
  
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  var restNames = [];
  var user_favs;
  var userID;
  var data;
  bool loading;
  bool loaded_favs = true;
  

  getFavorites(context) async {
    setState(() {
      loading = true;
    });
    data = await widget._collectionFav.get();
    final favoritesAll = data.docs.map((doc) => doc.data()).toList();
    userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);

    for(var i = 0; i < favoritesAll.length; i++){
      var studentID = (jsonDecode(jsonEncode(favoritesAll[i]))['studentID']);
      if(studentID == userID){
        user_favs = data.docs[i];
        restNames = ((jsonDecode(jsonEncode(favoritesAll[i]))['restaurtsName']));
      }
        
    }

    setState(() {
      loading = false;
    });

  }

  isFavorite(){
    
    var name = widget.restaurant.name;
    _isFavorited =  restNames.contains(name);
    loaded_favs = false;
  }

  removeFavorite(name){
    restNames.remove(name);
    widget._collectionFav.doc(user_favs.id).delete();

    widget._collectionFav.add({
      'studentID': userID,
      'restaurtsName' : restNames
    });
    //widget._collectionFav.doc(user_favs.id).delete();
  }

  addFavorite(name){
    restNames.add(name);
    widget._collectionFav.doc(user_favs.id).delete();
    
    widget._collectionFav.add({
      'studentID': userID,
      'restaurtsName' : restNames
    });
  }

  @override
  Widget build(BuildContext context) {
    
    getFavorites(context);
    isFavorite();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
            onPressed: (){
            if(_isFavorited){
              removeFavorite(widget.restaurant.name);
            }else{
              addFavorite(widget.restaurant.name);
            }
            setState(()
            {

              _isFavorited = !_isFavorited;
            });
            
          }),
          ),
      ],
    );
  }
  // ···
}