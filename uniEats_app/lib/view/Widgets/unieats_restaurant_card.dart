// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
//import 'dart:html';


import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/map_utils.dart';
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

class UniEatsRestaurantCard extends StatefulWidget {
  Restaurant restaurant;
  String day;
  bool isHomepage;
  String title;

  Position pos;
  var scheduleList;
  var coords;
  double distance;
  bool isOpen = false;
  final restDB = FirebaseFirestore.instance.collection('restaurants');

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

  // UniEatsRestaurantCardState.fromEditingInformation(
  //     Key key, bool editingMode, Function onDelete)
  //     : widget.fromEditingInformation(key, editingMode, onDelete);

  String getTitle() => title;

  onClick(BuildContext context) => Navigator.pushNamed(
        context,
        '/' + Constants.navRestaurant,
        arguments: restaurant,
      );

  @override
  UniEatsRestaurantCardState createState() => UniEatsRestaurantCardState();
}

class UniEatsRestaurantCardState extends State<UniEatsRestaurantCard> {
  MapUtils mapUtils = MapUtils();
  bool loading = false;
  final double borderRadius = 10.0;
  final double padding = 12.0;

  @override
  initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    setState(() {
      loading = true;
    });

    if (widget.isHomepage) {
      widget.pos = await mapUtils.checkGps();

      var data = await widget.restDB.get();
      int priceRange;

      for (int i = 0; i < data.size; i++) {

        if (data.docs[i]['name'] == 'Cantina - Almoço' &&
            widget.restaurant.name == 'Cantina - Jantar') {
          priceRange = data.docs[i]['priceRange'];
          widget.coords = data.docs[i]['coords'];
          continue;
        } else if (data.docs[i]['name'] == 'Cantina - Jantar' &&
            priceRange != null) {
          widget.scheduleList = data.docs[i]['schedule'];
          break;
        } else if (data.docs[i]['name'] == widget.restaurant.name) {
          priceRange = data.docs[i]['priceRange'];
          widget.scheduleList = data.docs[i]['schedule'];
          widget.coords = data.docs[i]['coords'];
          break;
        }
      }

      if(widget.scheduleList != null){
      //Compute isOpen
      var now = DateTime.now();
      var weekDay = now.weekday - 1;

      var hours = now.hour;
      var minutes = now.minute;


      String scheduleToday = widget.scheduleList[weekDay];
     
      if (scheduleToday != 'Fechado' || scheduleToday == null) {
        var dayScheSplit = scheduleToday.split(' ');
        var opening = dayScheSplit[0].split(':');
        var closing = dayScheSplit[2].split(':');

        var openH = int.parse(opening[0]);
        var openM = int.parse(opening[1]);

        var closeH = int.parse(closing[0]);
        var closeM = int.parse(closing[1]);

        if (hours < openH || hours > closeH) {
          widget.isOpen = false;
        } else if (hours > openH && hours < closeH) {
          widget.isOpen = true;
        } else if (hours == openH && minutes >= openM) {
          widget.isOpen = true;
        } else if (hours == closeH && minutes < closeM) {
          widget.isOpen = true;
        }
      } else {
        widget.isOpen = false;
      }

      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Tuple2<Restaurant, String> tuple =
        Tuple2(widget.restaurant, widget.day);

    return GestureDetector(
        onTap: () => widget.onClick(context),
        child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Color.fromARGB(0, 0, 0, 0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(this.borderRadius)),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(0x1c, 0, 0, 0),
                        blurRadius: 7.0,
                        offset: Offset(0.0, 1.0))
                  ],
                  color: Theme.of(context).dividerColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(this.borderRadius))),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 60.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(this.borderRadius))),
                  width: (double.infinity),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                            child: Text(widget.getTitle(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .apply(
                                        fontSizeDelta: -53,
                                        fontWeightDelta: -3)),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: EdgeInsets.only(top: 15, bottom: 10),
                          )),
                        ]
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          height: 5,
                          color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.only(
                          left: this.padding,
                          right: this.padding,
                          bottom: this.padding,
                        ),
                        child: getCardContent(tuple, context),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget getCardContent(tuple, context){
    return loading
        ? Center(child: Text('Loading...'))
        : RequestDependentWidgetBuilder(
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
    if (meals != null) {
      return Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: getMealRows(context, meals),
      ));
    }
    return Container(
        child: Text(
            "Não existem refeições para apresentar neste dia.\n Pressione para ver refeiçóes de outros dias"));
  }

  List<Widget> getMealRows(context, List<Meal> meals) {
    final List<Widget> rows = <Widget>[];
    bool click = false;

    if (widget.isHomepage) {
      //Compute Distance to current location && return
      var distance = Geolocator.distanceBetween(widget.coords.latitude,
          widget.coords.longitude, widget.pos.latitude, widget.pos.longitude);
      String helpText;

      if (distance >= 1000.0) {
        distance = distance * pow(10, -3);
        helpText = ' km';
      } else {
        helpText = ' m';
      }

      distance = double.parse((distance).toStringAsFixed(2));

      rows.add(
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.pin_drop_outlined),
                Text(distance.toString() + helpText,
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold)), //for location to current place
              ],
            ),
            Spacer(),
            widget.scheduleList != null
              ?  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined),
                Padding(padding: EdgeInsets.only(left: 2)),
                widget.isOpen
                    ? Text(
                        'Aberto',
                        style: TextStyle(
                            color: Colors.green.shade900,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      )
                    : Text('Fechado',
                        style: TextStyle(
                            color: Color.fromARGB(255, 141, 15, 23),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold))
              ],
            )
            : Container(),
            Spacer(),
            FavoriteWidget(),
          ],
        ),
      );
    }

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
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  final CollectionReference _collectionFav = FirebaseFirestore.instance.collection('favorites');

  Future<List> getFavorites(context) async {
    QuerySnapshot querySnapshot = await _collectionFav.get();
    final favorites_all = querySnapshot.docs.map((doc) => doc.data()).toList();
    var userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);
    var user_favorites = [];
    //print("[GET_FAV]");
    for(var i = 0; i < favorites_all.length; i++){
      var studentID = (jsonDecode(jsonEncode(favorites_all[i]))['studentID']);
      if(studentID == userID){
        //print((jsonDecode(jsonEncode(favorites_all[i]))['restaurtsName']));
        return((jsonDecode(jsonEncode(favorites_all[i]))['restaurtsName']));
      }
        
    }

    return user_favorites;
  
  }

  @override
  Widget build(BuildContext context) {
    getFavorites(context);
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
              onPressed: () {
                setState(() {
                  _isFavorited = !_isFavorited;
                });
              }),
        ),
      ],
    );
  }
  // ···
}
