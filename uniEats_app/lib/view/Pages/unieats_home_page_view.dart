import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/view/Widgets/unieats_restaurant_card.dart';
import 'package:uni/utils/constants.dart' as Constants;

import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';

class UniEatsHomePageView extends StatefulWidget {
  UniEatsHomePageView(
      {Key key,
      @required this.restaurants,
      });
  final List<Restaurant> restaurants;
  
  @override
  State<StatefulWidget> createState() => UniEatsHomePageViewState(restaurants: restaurants);
}

/// Manages the 'about' section of the app.
class UniEatsHomePageViewState extends UniEatsGeneralPageViewState {

  UniEatsHomePageViewState(
      {Key key,
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
  List<Widget> homepageData(BuildContext context, List<Restaurant> restaurants) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final List<Widget> data = <Widget>[];

    data.add(Row(children: [
      Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 80,
        width: queryData.size.width / 2,
        child: ButtonTheme(
            minWidth: 0,
            padding: EdgeInsets.only(left: 0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(),
            child: Card(
                elevation: 5,
                child: TextButton(
                  onPressed: () {
                    final currentRouteName =
                        ModalRoute.of(context).settings.name;
                    if (currentRouteName != Constants.navFavourites) {
                      Navigator.pushNamed(
                          context, '/${Constants.navFavourites}');
                    }
                  },
                  child: Text(
                  'Favoritos',
                style: TextStyle(
                  color: Color(0xff791d24),
                  ),
                )
                ))),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 80,
        width: queryData.size.width / 2,
        child: ButtonTheme(
            minWidth: 0,
            padding: EdgeInsets.only(left: 0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(),
            child: Card(
                elevation: 5,
                child: TextButton(
                  onPressed: () {
                    final currentRouteName =
                        ModalRoute.of(context).settings.name;
                    if (currentRouteName != Constants.navHistory) {
                      Navigator.pushNamed(context, '/${Constants.navHistory}');
                    }
                  },
                  child: Text(
                  'Histórico',
                style: TextStyle(
                  color: Color(0xff791d24),
                  ),
                )))),
      )
    ]));

    data.add(Row(children: [
      Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 80,
        width: queryData.size.width,
        child: ButtonTheme(
            minWidth: 0,
            padding: EdgeInsets.only(left: 0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(),
            child: Card(
                elevation: 5,
                child: TextButton(
                  child: Text(
                  'Ementa de hoje (' + DateFormat('dd/MM/yyyy').format(DateTime.now()) + ")",
                style: TextStyle(
                  color: Color(0xff791d24),
                  ),
                )))),
      )
    ]));
    if(restaurants != null){ 
      for(int i = 0; i < restaurants.length; i++){
        data.add(UniEatsRestaurantCard(restaurants[i]));
      }
    }
    
    return data;
  }
}
