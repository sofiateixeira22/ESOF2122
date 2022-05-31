import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uni/controller/map_utils.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni/model/utils/day_of_week.dart';

class Arguments {
  final Restaurant restaurant;

  Arguments(this.restaurant);
}

class RestaurantInfoPageView extends StatefulWidget {
  
  final Restaurant restaurant;
  RestaurantInfoPageView({
    Key key,
    @required this.restaurant,
  });

  @override
  RestaurantInfoPageViewState createState() => RestaurantInfoPageViewState();
}
class RestaurantInfoPageViewState extends State<RestaurantInfoPageView> {

  final Stream<QuerySnapshot> restDB =
      FirebaseFirestore.instance.collection('restaurants').snapshots();

  int priceRange;
  double starRating;
  int numPeople;
  var scheduleList;
  String linkImage;
  String address;
  var coords;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    double sizePrice = 20.0;

    return StreamBuilder(
        stream: restDB,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          final data = snapshot.requireData;

          for (int i = 0; i < data.size; i++) {
            if (data.docs[i]['name'] == 'Cantina - Almoço' &&
                widget.restaurant.name == 'Cantina - Jantar') {

              priceRange = data.docs[i]['priceRange'];
              starRating = double.parse(data.docs[i]['starRating']);
              numPeople = data.docs[i]['capacity'];
              linkImage = data.docs[i]['linkImage'];
              address = data.docs[i]['address'];
              coords = data.docs[i]['coords'];
              continue;
            } else if (data.docs[i]['name'] == 'Cantina - Jantar' &&
                priceRange != null) {

              scheduleList = data.docs[i]['schedule'];
              break;
            } else if (data.docs[i]['name'] == widget.restaurant.name) {

              priceRange = data.docs[i]['priceRange'];
              starRating = double.parse(data.docs[i]['starRating']);
              numPeople = data.docs[i]['capacity'];
              scheduleList = data.docs[i]['schedule'];
              linkImage = data.docs[i]['linkImage'];
              address = data.docs[i]['address'];
              coords = data.docs[i]['coords'];
              break;
            }
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                linkImage != null
                    ? Container(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        height: 225,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(linkImage),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                Container(
                  padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                  height: queryData.size.height /2,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: getCapacity(context)),
                            Row(children: getStarRatingView(context)),
                            Row(children: getPriceCategory(context)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Divider(
                          height: 5,
                          color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getOpenNow(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        //TODO: Mudar para dar para expandir e recolher
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getSchedule(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Divider(
                          height: 5,
                          color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getLocation(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<Widget> getCapacity(BuildContext context) {
    List<Widget> capacityList = [];

    if (numPeople != null) {
      capacityList.add(Text(
        numPeople.toString(),
        style: Theme.of(context).textTheme.bodyLarge.apply(),
      ));

      capacityList.add(Icon(
        Icons.person,
        color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
        size: 20.0,
      ));
    }

    return capacityList;
  }

  List<Widget> getPriceCategory(BuildContext context) {
    List<Widget> price_cat = [];
    double sizePrice = 20.0;

    price_cat.add(Text(
      'Preço: ',
      style: Theme.of(context).textTheme.bodyLarge.apply(),
    ));

    for (int num = 0; num < priceRange; num++) {
      price_cat.add(Icon(
        Icons.euro_symbol_sharp,
        color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
        size: sizePrice,
      ));
    }

    return price_cat;
  }

  List<Widget> getStarRatingView(BuildContext context) {
    List<Widget> star_rating = [];
    final double sizeStar = 20.0;

    star_rating.add(Text(
      starRating.toString() + ' ',
      style: Theme.of(context).textTheme.bodyLarge.apply(),
    ));

    int num_stars = starRating.floor();

    for (int num = 0; num < num_stars; num++) {
      star_rating.add(Icon(
        Icons.star,
        color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
        size: sizeStar,
      ));
    }

    double half_star = starRating - num_stars;

    if (half_star != 0.0) {
      star_rating.add(Icon(
        Icons.star_half,
        color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
        size: sizeStar,
      ));
    }

    int stars_left = 5 - starRating.ceil();
    for (int i = 0; i < stars_left; i++) {
      star_rating.add(Icon(
        Icons.star_border,
        color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
        size: sizeStar,
      ));
    }

    return star_rating;
  }

  List<Widget> getOpenNow(BuildContext context) {
    List<Widget> open_now = [];

    bool open = false;
    String helpText = '';

    if (scheduleList != null) {
      var now = DateTime.now();
      var weekDay = now.weekday - 1;

      var hours = now.hour == 23 ? 0 : now.hour + 1;
      var minutes = now.minute;

      String scheduleToday = scheduleList[weekDay];

      var tmrDay = weekDay == 6 ? 0 : weekDay + 1;
      String scheduleTomorrow = scheduleList[tmrDay];
      var openHTmr;
      
      if(scheduleTomorrow != 'Fechado'){
        openHTmr = scheduleTomorrow.split(' ')[0];
      } else {
        openHTmr = 'Fechado';
      }

      if(scheduleToday != 'Fechado'){
        var dayScheSplit = scheduleToday.split(' ');
        var opening = dayScheSplit[0].split(':');
        var closing = dayScheSplit[2].split(':');


        var openH = int.parse(opening[0]);
        var openM = int.parse(opening[1]);

        var closeH = int.parse(closing[0]);
        var closeM = int.parse(closing[1]);

        if (hours < openH) {
          open = false;
          helpText = ' - Abre às ' + dayScheSplit[0];
        } else if (hours > closeH) {
          open = false;
          helpText = ' - Abre às ' + openHTmr;
        } else if (hours > openH && hours < closeH) {
          open = true;
          helpText = ' - Encerra às ' + dayScheSplit[2];
        } else if (hours == openH && minutes >= openM) {
          open = true;
          helpText = ' - Encerra às ' + dayScheSplit[2];
        } else if (hours == closeH && minutes < closeM) {
          open = true;
          helpText = ' - Encerra às ' + dayScheSplit[2];
        }
      } else {
        open = false;
        helpText = openHTmr != 'Fechado'
                    ? ' - Abre às ' + openHTmr 
                    : ' - Abre depois de amanhã'; 
      }

      open_now.add(open
          ? Text(
              'Aberto',
              style: TextStyle(
                  color: Colors.green.shade900,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          : Text('Fechado',
              style: TextStyle(
                  color: Color.fromARGB(255, 141, 15, 23),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)));

      open_now.add(Text(
        helpText,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ));
    }

    return open_now;
  }

  List<Widget> getSchedule(BuildContext context) {
    List<Widget> schedule = [];

    if (scheduleList != null) {
      schedule.add(Text(
        'Horário Semanal:',
        style: TextStyle(
            fontSize: 15.0,
            color: Color.fromARGB(255, 141, 15, 23),
            fontWeight: FontWeight.bold),
      ));

      List<String> daysOfWeek = [
        '2a feira',
        '3a feira',
        '4a feira',
        '5a feira',
        '6a feira',
        'Sábado',
        'Domingo'
      ];

      for (var idx = 0; idx < scheduleList.length; idx++) {
        schedule.add(Text(daysOfWeek[idx] + ': ' + scheduleList[idx]));
      }
    } else {
      schedule.add(Text(
        'Horário Não Disponível',
        style: TextStyle(
            fontSize: 15.0,
            color: Color.fromARGB(255, 141, 15, 23),
            fontWeight: FontWeight.bold),
      ));
    }

    return schedule;
  }

  List<Widget> getLocation(BuildContext context) {
    List<Widget> location_list = [];

    final MediaQueryData queryData = MediaQuery.of(context);

    location_list.add(
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            address,
            style: TextStyle(
              fontSize: 15.0,
              ),
            ),
    ));

    location_list.add(
      Padding(
        padding: EdgeInsets.only(top: 30),
      ),
    );

    location_list.add(
      Container(
        height: 50.0,
        width: queryData.size.width *0.70,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 141, 15, 23)),
           borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
            'Abrir Localização no Google Maps',
            style: TextStyle(
              fontSize: 15.0,
              ),
            ),
            Icon(
              Icons.pin_drop,
              color: Color.fromARGB(255, 141, 15, 23),
            )
          ],),
          onPressed: () {
            MapUtils.openMap(coords.latitude, coords.longitude);
          },
        )
      ),
      );

    return location_list;
  }
}
