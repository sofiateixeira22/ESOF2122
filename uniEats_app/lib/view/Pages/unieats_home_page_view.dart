import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/utils/constants.dart' as Constants;

class UniEatsHomePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UniEatsHomePageViewState();
}

/// Manages the 'about' section of the app.
class UniEatsHomePageViewState extends UniEatsGeneralPageViewState {
  @override
  Widget getBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: restaurantsHomepage(context),
        )),
      ],
    );
  }

  ///Returns a list of the restaurants to appear in the unieats homepage
  List<Widget> restaurantsHomepage(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final List<Widget> restaurants = <Widget>[];

    restaurants.add(Row(children: [
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

    //Está hardcoded para ter dummys
    //ter uma função para ir buscar restaurantes da base de dados
    for (int i = 0; i < 10; i++) {
      restaurants.add(Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 220,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: (Center(
              child: Text('Restaurant Placeholder'),
            )),
          )));
    }

    return restaurants;
  }
}
