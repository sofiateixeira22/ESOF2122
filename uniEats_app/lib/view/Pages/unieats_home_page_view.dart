import 'package:flutter/material.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/view/Widgets/unieats_restaurant_card.dart';

import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../Widgets/unieats_restaurant_search.dart';

class UniEatsHomePageView extends StatefulWidget {
  UniEatsHomePageView({
    Key key,
    @required this.restaurants,
  });
  final List<Restaurant> restaurants;

  @override
  State<StatefulWidget> createState() =>
      UniEatsHomePageViewState(restaurants: restaurants);
}

/// Manages the 'about' section of the app.
class UniEatsHomePageViewState extends UniEatsGeneralPageViewState {
  UniEatsHomePageViewState({
    Key key,
    @required this.restaurants,
  });
  final List<Restaurant> restaurants;

  @override
  Widget getBody(BuildContext context) {
    return StoreConnector<AppState, List<Restaurant>>(
      converter: (store) => (store.state.content['restaurants']),
      builder: (context, restaurants) {
        return ListView(
          children: <Widget>[
            Container(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: homepageData(context, restaurants),
            )),
          ],
        );
      },
    );
  }

  ///Returns a list of the restaurants to appear in the unieats homepage
  List<Widget> homepageData(
      BuildContext context, List<Restaurant> restaurants) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final List<Widget> data = <Widget>[];

    data.add(Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text(
                    'Ementa de hoje (' +
                        DateFormat('dd/MM/yyyy').format(DateTime.now()) +
                        ")",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .apply(fontSizeFactor: 1.3),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(5, 20, 25, 5),
                  icon: const Icon(Icons.search),
                  onPressed: () => showSearch(
                      context: context,
                      delegate: RestaurantSearch(context, restaurants)
                  ),
                ),
              ],
            ));
    if (restaurants != null) {
        String day = DateFormat('EEEE').format(DateTime.now());
      for (int i = 0; i < restaurants.length; i++) {
        if(restaurants[i].hasMeals(day)){
          data.add(UniEatsRestaurantCard(
              restaurants[i], day,restaurants[i].name, true));
        }
      }
      for (int i = 0; i < restaurants.length; i++) {
        if(!restaurants[i].hasMeals(day)){
          data.add(UniEatsRestaurantCard(
              restaurants[i], day, restaurants[i].name,true));
        }
      }
    }
    return data;
  }
}
