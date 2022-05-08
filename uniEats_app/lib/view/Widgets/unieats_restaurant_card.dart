// ignore_for_file: lines_longer_than_80_chars

import 'dart:ffi';
//import 'dart:html';

import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/app_state.dart';
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

  UniEatsRestaurantCard(
    Restaurant restaurant,
    String day,
    bool isHomepage, {
    Key key,
  })  : restaurant = restaurant,
        day = day,
        isHomepage = isHomepage,
        super(key: key);

  UniEatsRestaurantCard.fromEditingInformation(
      Key key, bool editingMode, Function onDelete)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  String getTitle() => this.restaurant.name;

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
        contentChecker: restaurant.hasMeals(day),
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
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: getMealRows(context, meals),
    ));
  }

  List<Widget> getMealRows(context, List<Meal> meals) {
    final List<Widget> rows = <Widget>[];
    bool click = false;
    //add favorite button, times and location(?)
    if (isHomepage) {
      rows.add(Row(
        children: [
        Row(
          children: [
            Icon(Icons.pin_drop_outlined),
            Text('50m'), //for location to current place
          ],
        ),
        Spacer(),
        Row(children: [
          Icon(Icons.timer_outlined),
          Text('t_open') //for timeopen
        ],),
        Spacer(),
        FavoriteWidget(),

      ]));
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

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
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