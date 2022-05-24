import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
class RestaurantReviewsPageView extends StatelessWidget {
  RestaurantReviewsPageView(
      {Key key,
      @required this.restaurant,
      });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final Restaurant restaurant =
        ModalRoute.of(context).settings.arguments as Restaurant;

    return Review();

  }
}

class Review extends StatefulWidget{
  const Review({key});

  @override
  State<StatefulWidget> createState() {
   return ReviewState();
  }

}

class ReviewState extends State<Review>{

  final Stream<QuerySnapshot> reviews = FirebaseFirestore.instance.collection("reviews").snapshots();
   final _reviewKey = GlobalKey<ReviewState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          key: _reviewKey,
          padding: const EdgeInsets.symmetric(vertical:20, horizontal: 20),
          child: StreamBuilder<QuerySnapshot>(
              stream: reviews,
              builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                  ){
                if (snapshot.hasError){return Text("Something went wrong");}
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("Loading");
                }
                final data = snapshot.requireData;

                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index){
                      return Text("The student ${data.docs[index]['studentID']} rated the restaurant ${data.docs[index]['restaurantID']} ${data.docs[index]['starRating']} stars.");
                    }
                );
              }
          ),
        ),
        
      );
  }

}
