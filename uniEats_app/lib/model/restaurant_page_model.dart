import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Pages/restaurant_page_view.dart';
import 'package:uni/view/Pages/schedule_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class   RestaurantPage extends StatefulWidget {
  const   RestaurantPage({Key key}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
  final int weekDay = DateTime.now().weekday;
  Restaurant restaurant;
  TabController tabController;
  ScrollController scrollViewController;

  final List<String> daysOfTheWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira'
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: daysOfTheWeek.length);
    final offset = (weekDay > 5) ? 0 : (weekDay - 1) % daysOfTheWeek.length;
    tabController.animateTo((tabController.index + offset));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    Logger().e("getBody");
    restaurant = ModalRoute.of(context).settings.arguments as Restaurant;
    return RestaurantPageView(
      tabController: tabController,
      scrollViewController: scrollViewController,
      daysOfTheWeek: daysOfTheWeek,
      meals: restaurant.getMealsOfDayInt(weekDay),
    );
  }
}
