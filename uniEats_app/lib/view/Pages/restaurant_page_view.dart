import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Pages/restaurant_info_page.dart';
import 'package:uni/view/Pages/restaurant_menu_page.dart';
import 'package:uni/view/Pages/restaurant_reviews_page.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'package:uni/view/Widgets/schedule_slot.dart';
import 'package:uni/view/Widgets/unieats_restaurant_card.dart';

class Arguments {
  final Restaurant restaurant;

  Arguments(this.restaurant);
}

/// Manages the 'schedule' sections of the app
class RestaurantPageView extends StatelessWidget {
  RestaurantPageView(
      {Key key,
      @required this.tabController,
      @required this.menuTabController,
      @required this.restaurant,
      @required this.restaurantStatus,
      @required this.daysOfTheWeek,
      @required this.tabNames,
      this.scrollViewController,
      this.menuScrollViewController});

  final Restaurant restaurant;
  final List<String> daysOfTheWeek;
  final RequestStatus restaurantStatus;
  final TabController tabController;
  final ScrollController scrollViewController;

  final List<String> tabNames;
  final TabController menuTabController;
  final ScrollController menuScrollViewController;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final Restaurant restaurant =
        ModalRoute.of(context).settings.arguments as Restaurant;

    return Column(children: <Widget>[
      ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          PageTitle(name: restaurant.name),
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: createTabs(queryData, context),
          ),
        ],
      ),
      Expanded(
          child: TabBarView(
        controller: tabController,
        children: [RestaurantInfoPageView(
                restaurant: restaurant,
                ),
                RestaurantMenuPageView(
                tabController: menuTabController,
                scrollViewController: menuScrollViewController,
                daysOfTheWeek: daysOfTheWeek,
                restaurant: restaurant,
                ),
                RestaurantReviewsPageView(
                restaurant: restaurant,
                )]
      ))
    ]);
  }

  /// Returns a list of widgets empty with tabs for each day of the week.
  List<Widget> createTabs(queryData, BuildContext context) {
    final List<Widget> tabs = <Widget>[];
    for (var i = 0; i < tabNames.length; i++) {
      tabs.add(Container(
        color: Theme.of(context).backgroundColor,
        width: queryData.size.width * 1 / 3,
        child: Tab(key: Key('restaurant-page-tab-$i'), text: tabNames[i]),
      ));
    }
    return tabs;
  }


}
