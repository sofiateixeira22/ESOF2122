import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Pages/restaurant_page_view.dart';
import 'package:uni/view/Pages/schedule_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/view/Pages/unieats_nodrawer_page_view.dart';

class   RestaurantPage extends StatefulWidget {
  const   RestaurantPage({Key key}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends UniEatsNoDrawerPageView
    with TickerProviderStateMixin {
  final int weekDay = DateTime.now().weekday;
  Restaurant restaurant;
  TabController tabController;
  ScrollController scrollViewController;


  TabController menuTabController;
  ScrollController menuScrollViewController;

   final List<String> tabNames = [
    'Info',
    'Menu',
    'Reviews',
  ]; 

  final List<String> daysOfTheWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];


  @override
  void initState() {
    super.initState();
    
    tabController = TabController(vsync: this, length: tabNames.length);

    menuTabController = TabController(vsync: this, length: 0);
    tabController.animateTo((tabController.index + 1));
  }

  @override
  void dispose() {
    tabController.dispose();
    menuTabController.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    restaurant = ModalRoute.of(context).settings.arguments as Restaurant;
    int count = 0;

    for(int i = 0; i< daysOfTheWeek.length; i++){
      if(restaurant.hasMeals(daysOfTheWeek[i])){
        count++;
      }
    }
    Logger().e("Count: " + count.toString());
    menuTabController = TabController(vsync: this, length: count);

    final offset = (weekDay > 7) ? 0 
                  : ((weekDay - 1) % daysOfTheWeek.length) - (weekDay - 1);

    menuTabController.animateTo((menuTabController.index + offset));
    return RestaurantPageView(
      tabController: tabController,
      scrollViewController: scrollViewController,
      menuTabController: menuTabController,
      menuScrollViewController: menuScrollViewController,
      daysOfTheWeek: daysOfTheWeek,
      tabNames: tabNames,
      restaurant: restaurant,
    );
  }
}
