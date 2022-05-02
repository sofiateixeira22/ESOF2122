import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
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
      @required this.restaurant,
      @required this.restaurantStatus,
      @required this.daysOfTheWeek,
      this.scrollViewController});

      

  final Restaurant restaurant;
  final List<String> daysOfTheWeek;
  final RequestStatus restaurantStatus;
  final TabController tabController;
  final ScrollController scrollViewController;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final Restaurant restaurant = ModalRoute.of(context).settings.arguments as Restaurant;

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
        children: createMeals(context),
        )
      )
    ]);
  }

  /// Returns a list of widgets empty with tabs for each day of the week.
  List<Widget> createTabs(queryData, BuildContext context) {
    final List<Widget> tabs = <Widget>[];
    for (var i = 0; i < daysOfTheWeek.length; i++) {
      tabs.add(Container(
        color: Theme.of(context).backgroundColor,
        width: queryData.size.width * 1 / 3,
        child: Tab(key: Key('restaurant-page-tab-$i'), text: daysOfTheWeek[i]),
      ));
    }
    return tabs;
  }

  List<Widget> createMeals(context) {
    final List<Widget> tabBarViewContent = <Widget>[];
    for (int i = 0; i < daysOfTheWeek.length; i++) {
      tabBarViewContent.add(UniEatsRestaurantCard(restaurant, daysOfTheWeek[i]));
    }
    return tabBarViewContent;
  }

  /// Returns a list of widgets for the rows with a singular class info.
  List<Widget> createMealsRows(lectures, BuildContext context) {
    final List<Widget> scheduleContent = <Widget>[];
    for (int i = 0; i < lectures.length; i++) {
      final Lecture lecture = lectures[i];
      scheduleContent.add(ScheduleSlot(
        subject: lecture.subject,
        typeClass: lecture.typeClass,
        rooms: lecture.room,
        begin: lecture.startTime,
        end: lecture.endTime,
        teacher: lecture.teacher,
        classNumber: lecture.classNumber,
      ));
    }
    return scheduleContent;
  }

  Widget Function(dynamic daycontent, BuildContext context) dayColumnBuilder(
      int day) {
    Widget createDayColumn(dayContent, BuildContext context) {
      return Container(
          key: Key('schedule-page-day-column-$day'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: createMealsRows(dayContent, context),
          ));
    }

    return createDayColumn;
  }

  Widget createMealsByDay(BuildContext context, int day) {
    return RequestDependentWidgetBuilder(
      context: context,
      status: restaurantStatus,
      contentGenerator: dayColumnBuilder(day),
      content: restaurant.getMealsOfDayInt(day),
      contentChecker: restaurant.getMealsOfDayInt(day).isNotEmpty,
      onNullContent:
          Center(child: Text('Não existem refeições neste dia ' + daysOfTheWeek[day] + '.')),
      index: day,
    );
  }
}
