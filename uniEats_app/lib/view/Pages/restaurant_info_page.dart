import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Arguments {
  final Restaurant restaurant;

  Arguments(this.restaurant);
}

/// Manages the 'schedule' sections of the app
class RestaurantInfoPageView extends StatelessWidget {
  RestaurantInfoPageView({
    Key key,
    @required this.restaurant,
  });

  final Restaurant restaurant;
  final Stream<QuerySnapshot> restDB = FirebaseFirestore.instance
                                        .collection('restaurants').snapshots();
  
  int priceRange;
  double starRating;
  int numPeople;
  var scheduleList;
  String linkImage;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    double sizePrice = 20.0;

    return StreamBuilder(
      stream: restDB,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot
                  ) {
        if (snapshot.hasError){return Text('Something went wrong');}
        if(snapshot.connectionState == ConnectionState.waiting){
                  return Text('Loading');
                }

              final data = snapshot.requireData;

              for (int i = 0; i < data.size; i++){
                if(data.docs[i]['name'] == 'Cantina - Almoço' && restaurant.name == 'Cantina - Jantar'){
                  priceRange = data.docs[i]['priceRange'];
                  starRating = double.parse(data.docs[i]['starRating']);
                  numPeople = data.docs[i]['capacity'];
                  linkImage = data.docs[i]['linkImage'];
                  continue;
                }

                if(data.docs[i]['name'] == 'Cantina - Jantar'){
                  scheduleList = data.docs[i]['schedule'];
                  break;
                }

                if(data.docs[i]['name'] == restaurant.name){
                  priceRange = data.docs[i]['priceRange'];
                  starRating = double.parse(data.docs[i]['starRating']);
                  numPeople = data.docs[i]['capacity'];
                  scheduleList = data.docs[i]['schedule'];
                  linkImage = data.docs[i]['linkImage'];
                  break;
                }
              }

              return SingleChildScrollView(
                child: 
              Column(             
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
        ) : Padding( padding: EdgeInsets.only(top: 20),),
        Container(
          padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
          height: queryData.size.height / 2,
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
    ),);
      }
  );

  }

  List<Widget> getCapacity(BuildContext context) {
    List<Widget> capacityList = [];

    if(numPeople != null){
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

    bool open = false; //TODO: get de acordo com as horas e o horário

    if (open) {
      open_now.add(Text(
        'Aberto',
        style: TextStyle(
            color: Colors.green.shade900,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ));

      open_now.add(Text(
        ' - Encerra às 14:00', //TODO: Tirar o HardCoded
        style: TextStyle(
          fontSize: 20.0,
        ),
      ));
    } else {
      open_now.add(Text(
        'Fechado',
        style: TextStyle(
            color: Color.fromARGB(255, 141, 15, 23),
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ));

      open_now.add(Text(
        ' - Abre às 12:00',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ));
    }
    return open_now;
  }

  List<Widget> getSchedule(BuildContext context) {
    List<Widget> schedule = [];

    schedule.add(Text(
      'Horário Semanal:',
      style: TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 141, 15, 23),
          fontWeight: FontWeight.bold),
    ));

    List<String> daysOfWeek = ['2a feira', '3a feira', '4a feira', 
                  '5a feira', '6a feira', 'Sábado', 'Domingo'];

    for(var idx = 0; idx < scheduleList.length; idx++){
      schedule.add(Text(daysOfWeek[idx] + ': ' + scheduleList[idx]));
    }

    return schedule;
  }

  List<Widget> getLocation(BuildContext context) {
    List<Widget> location_list = [];

    location_list.add(Text(
      'Tv. de Lamas 22, Porto',
      style: TextStyle(
        fontSize: 20.0,
      ),
    ));

    location_list.add(Padding(
                  padding: EdgeInsets.only(top: 30),
                ),);

    location_list.add(Text(
      'Google Map :)',
      style: TextStyle(
        fontSize: 15.0,
      ),
    ));

    return location_list;
  }
}
