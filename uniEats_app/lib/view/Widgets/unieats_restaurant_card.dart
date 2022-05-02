
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Widgets/meal_slot.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'date_rectangle.dart';
import 'generic_card.dart';
import 'package:intl/intl.dart';

class UniEatsRestaurantCard extends GenericCard {
  Restaurant restaurant;
  UniEatsRestaurantCard(Restaurant restaurant, {
    Key key,}) : restaurant = restaurant, super(key: key);

  UniEatsRestaurantCard.fromEditingInformation(
    Key key, bool editingMode, Function onDelete) 
  : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  String getTitle() => this.restaurant.name;

  @override
  onClick(BuildContext context) =>
      null;

  // @override
  // Widget buildCardContent(BuildContext context) {
  //   Map<DayOfWeek, List<Meal>> meals = restaurant.meals;
  //   if(meals != null){
  //     meals.forEach((day,daymeals) => {
  //         daymeals.forEach((daymeal) =>
  //           Logger().e('${restaurant.name} -> ${day}: ${daymeal.name}')
  //         )
  //       }
  //     ); 
  //   }

  //   return Container(
  //     padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
  //     height: 220,
  //     width: double.maxFinite,
  //     child: Card(
  //       elevation: 5,
  //       child: (Center(
  //         child: Text('Restaurant Placeholder'),
  //       )),
  //     ));
  // }

  @override
  Widget buildCardContent(BuildContext context) {
    return RequestDependentWidgetBuilder(
        context: context,
        contentGenerator: generateMeals,
        content: restaurant,
        contentChecker:
            restaurant != null,
        onNullContent: Center(
            child: Text('Não existem restaurantes para apresentar',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center)));
  }



  Widget generateMeals(restaurant, context) {
    var day = DateFormat('EEEE').format(DateTime.now());
    DayOfWeek dayOfWeek;
    switch(day){
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

    final List<Widget> rows =  <Widget>[];

    final now = DateTime.now();

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
    Color color = Theme.of(context).textTheme.headline4.color;
    switch(meal.type){
      case "Vegetariano":
        color = Colors.green;
        break;
      // case "Peixe":
      //   color = Colors.cyan;
      //   break;
      // case "Carne":
      //   color = Colors.red;
      //   break;
      default: break;
    }

    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );

    List<Column> columns =[
      Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 3.0),
          child: Text(
              meal.type, 
              overflow: TextOverflow.ellipsis,
              style: textStyle,
          )
        )
      ],
    ),
    Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 3.0),
          width: 250,
          child: Text(
            meal.name, 
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          )
        )
      ],
    )
    ];
    
    Row row = Row(
      children: columns,
    );
    return Flexible(
child: row,
    );
  }


//   Widget generateRestaurant(canteens, context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         createRowFromRestaurant(context, canteens)
//       ],
//     );
//   }

//   Widget createRowFromRestaurant(context, String canteen) { // TODO: Issue #390
//     return Column(children: [
//       DateRectangle(date: ''), // TODO: Issue #390
//        // cantine.nextSchoolDay
//       Container(
//         child: Center(
//           child: Container(
//               padding: EdgeInsets.all(12.0),
//               child: Text(canteen)
//           )
//         ),
//       ),
//       Card(
//         elevation: 1,
//         child: RowContainer(
//           color:  Color.fromARGB(0, 0, 0, 0),
//           child:  RestaurantRow(
//             local: canteen,
//             meatMenu: '', // TODO: Issue #390
//             fishMenu: '',
//             vegetarianMenu: '',
//             dietMenu: '',
//          )
//         ),
//       ),
//     ]);
//   }
}

