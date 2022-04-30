
import 'package:logger/logger.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'date_rectangle.dart';
import 'generic_card.dart';

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

  @override
  Widget buildCardContent(BuildContext context) {
    Map<DayOfWeek, List<Meal>> meals = restaurant.meals;
    if(meals != null){
      meals.forEach((day,daymeals) => {
          daymeals.forEach((daymeal) =>
            Logger().e('${restaurant.name} -> ${day}: ${daymeal.name}')
          )

        }
      ); 
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: (Center(
          child: Text('Restaurant Placeholder'),
        )),
      ));
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
