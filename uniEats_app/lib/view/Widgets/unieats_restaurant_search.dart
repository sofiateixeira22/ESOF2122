import 'package:flutter/material.dart';
import 'package:uni/model/entities/restaurant.dart';

import 'package:uni/utils/constants.dart' as Constants;


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
          onTap: () => Navigator.pushNamed(
            context,
            '/' + Constants.navRestaurant,
            arguments: suggestions.elementAt(index),
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
          onTap: () => Navigator.pushNamed(
            context,
            '/' + Constants.navRestaurant,
            arguments: suggestions.elementAt(index),
          ),
        );
      },
    );
  }
}
