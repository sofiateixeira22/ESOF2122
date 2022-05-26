import 'package:flutter/material.dart';
import 'package:uni/model/entities/restaurant.dart';

/// Manages the section of the app displayed when the
/// user searches for a restaurant
class RestaurantSearch extends SearchDelegate<String> {
  List<Restaurant> restaurants;

  RestaurantSearch(BuildContext context, List<Restaurant> restaurants) {
    this.restaurants = restaurants;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = restaurants.where((restaurant) {
      return restaurant.name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(suggestions.elementAt(index).name,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = restaurants.where((restaurant) {
      return restaurant.name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(suggestions.elementAt(index).name,
          ),
          onTap: () {
            query = suggestions.elementAt(index).name;
            /*int i;
            for(i = 0; i < restaurants.length; i++) {
              if(suggestions.elementAt(index).name == restaurants[i].name) {
                break;
              }
            }
            String day = DateFormat('EEEE').format(DateTime.now());
            UniEatsRestaurantCard(
                restaurants[i], day,restaurants[i].name, true);*/
          },
        );
      },
    );
  }
}
