import 'dart:collection';
import 'package:logger/logger.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:collection/collection.dart';
import 'meal.dart';

class Restaurant{
  final int id;
  final String name;
  final String reference; // Used only in html parser
  final Map<DayOfWeek, List<Meal>> meals;


  Restaurant(this.id, this.name, this.reference, {List<Meal> meals = null})
        : this.meals = meals != null
            ? groupBy(meals, (meal) => meal.dayOfWeek)
            : HashMap.identity(){}

  static Restaurant fromMap(Map<String, dynamic> map){
    return Restaurant(map['id'], map['name'], map['ref'], meals:map['meals']);
  }

  List<Meal> getMealsOfDay(DayOfWeek dayOfWeek){
    return meals[dayOfWeek];
  }

    List<Meal> getMealsOfDayInt(int dayOfWeek){
    return meals[DayOfWeek.values[dayOfWeek]];
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'ref': reference
    };
  }

  hasMeals(String day) {
    DayOfWeek dayOfWeek;
    switch (day){
      case 'Monday':
        dayOfWeek = DayOfWeek.monday; break;
      case 'Tuesday':
        dayOfWeek = DayOfWeek.tuesday; break;
      case 'Wednesday':
        dayOfWeek = DayOfWeek.wednesday; break;
      case 'Thursday':
        dayOfWeek = DayOfWeek.thursday; break;
      case 'Friday':
        dayOfWeek = DayOfWeek.friday; break;
      case 'Saturday':
        dayOfWeek = DayOfWeek.saturday; break;
      case 'Sunday':
        dayOfWeek = DayOfWeek.sunday; break;
    }
    bool temp = false;
    meals.forEach((key, value) {
      if(key == dayOfWeek){
        temp = true;
      }
    });
    return temp;
  }
}