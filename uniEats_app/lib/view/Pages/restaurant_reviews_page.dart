
import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:uni/model/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/app_state.dart';
import 'package:quick_feedback/quick_feedback.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'package:uni/view/Widgets/schedule_slot.dart';
import 'package:uni/view/Widgets/unieats_restaurant_card.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/view/Widgets/unieats_review_card.dart';



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
   
    var restaurantInfo = restaurant.toMap();

    return SingleChildScrollView(
                child: Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          AddReview().build(context),
        SizedBox(
          height: queryData.size.height * (3/5),
          child: ReviewShower(),
        ),
        
      ],)
    ),);

  }
}

class ReviewShower extends StatefulWidget{
  const ReviewShower({key});

  @override
  State<StatefulWidget> createState() {
   return ReviewShowerState();
  }

}

class ReviewShowerState extends State<ReviewShower>{

  final Stream<QuerySnapshot> reviews = FirebaseFirestore.instance.collection("reviews").snapshots();
   final _reviewKey = GlobalKey<ReviewShowerState>();

  @override
  Widget build(BuildContext context) {
    return Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          key: _reviewKey,
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
                          return Card( 
                            elevation: 5,
                            child: UniEatsReviewCard(
                               "${data.docs[index]['studentID']}",
                               double.parse("${data.docs[index]['starRating']}"),
                               "${data.docs[index]['description']}"
                               ).buildCardContent(context));
                        }
                      );
  }), ), );

      
  }

}
class AddReview extends StatelessWidget{
  //CollectionReference reviews = FirebaseFirestore.instance.collection("reviews");
  
  void _showFeedback(context, restaurantName) {
    showDialog(
      context: context,
      builder: (context) {
  
        return QuickFeedback(
          title: 'Leave a Review', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              'Share your review', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitCallback: (feedback) {
            CollectionReference reviews = FirebaseFirestore.instance.collection("reviews");
            var starRating = (feedback.values.first);
            var userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);
            var description = (jsonDecode(jsonEncode(feedback))['feedback']);

            reviews
              .add({'starRating': starRating, 'description': description, 'restaurantID':restaurantName, 'studentID':  userID})
              .then((value) => print("Review Added"))
              .catchError((error)=> print("Failed to add review"));
            Navigator.of(context).pop();
          },
          askLaterText: '', //TODO remove the button
          onAskLaterCallback: () {
            print('Do something on ask later click');
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    //userID = 
    final Restaurant restaurant =
        ModalRoute.of(context).settings.arguments as Restaurant;
    final restaurantName = restaurant.toMap()['name'];
    return Container(
      padding: EdgeInsets.only(bottom: 5),
            child: Center(
              child: ElevatedButton(
                onPressed: () => _showFeedback(context, restaurantName),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0x75, 0x17, 0x1e),
                  textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
                child: Text('Add Review',style: new TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 0xfa, 0xfa, 0xfa)),),
              ),
            ));
  }

}
