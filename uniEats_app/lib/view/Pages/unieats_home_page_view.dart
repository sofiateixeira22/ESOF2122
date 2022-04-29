import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/view/Widgets/unieats_restaurant_card.dart';
import 'package:uni/utils/constants.dart' as Constants;

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
    return ListView(
      children: <Widget>[
        Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: homepageData(context),
        )),
      ],
    );
  }

  ///Returns a list of the restaurants to appear in the unieats homepage
  List<Widget> homepageData(BuildContext context) {
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
                  child: SvgPicture.asset(
                    'assets/images/favourites_styled.svg',
                    height: queryData.size.height / 10,
                  ),
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
                  child: SvgPicture.asset(
                    'assets/images/history_styled.svg',
                    height: queryData.size.height / 10,
                  ),
                ))),
      )
    ]));
    if(restaurants != null){ 
      for(int i = 0; i < restaurants.length; i++){
        data.add(UniEatsRestaurantCard(restaurants[i]));
      }
    }
    //Está hardcoded para ter dummys
    //ter uma função para ir buscar restaurantes da base de dados
    // for (int i = 0; i < 10; i++) {
    //   restaurants.add(Container(
    //       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    //       height: 220,
    //       width: double.maxFinite,
    //       child: Card(
    //         elevation: 5,
    //         child: (Center(
    //           child: Text('Restaurant Placeholder'),
    //         )),
    //       )));
    // }

    return data;
  }
}
