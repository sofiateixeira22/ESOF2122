
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


class RestaurantReviewsPageView extends StatefulWidget {
  RestaurantReviewsPageView(
      {Key key,
      @required this.restaurant,
      });

  final Restaurant restaurant;
  
   @override
  State<StatefulWidget> createState() => RestaurantReviewsPageViewState();
}
  class RestaurantReviewsPageViewState extends State<RestaurantReviewsPageView> {
  
  RestaurantReviewsPageViewState({
    Key key,
  });


  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    
    final Restaurant restaurant =
        ModalRoute.of(context).settings.arguments as Restaurant;
   
    var restName = restaurant.name;

    return SingleChildScrollView(
                child: Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
        SizedBox(
          height: queryData.size.height * (4/5),
          child: ReviewShower(restName),
        ),
        
      ],)
    ),);

  }
}

class ReviewShower extends StatefulWidget{
  final String restName;
  final reviewsDB = FirebaseFirestore.instance.collection('reviews');

  ReviewShower(String restName, {key}) : restName = restName;

  @override
  State<StatefulWidget> createState() {
   return ReviewShowerState();
  }

}

class ReviewShowerState extends State<ReviewShower>{
  bool loading = false;
  var data;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    setState(() {
      loading = true;
    });

    data = await widget.reviewsDB.get();
  

  setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool canAdd = true;
    String userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);

    if(loading){
      return Center(child: Text('Loading...'));
    } else {
      for (int i = 0; i < data.size; i++) {
            if(widget.restName == data.docs[i]['restaurantID']){
              if(userID == data.docs[i]['studentID']){
                canAdd = false;
                break;
              }
            }
          }

    return Column(children: [
                   canAdd 
                   ? AddReview().build(context)
                   : Container(height: 0),
                   SingleChildScrollView(
      child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: getReviews(userID),
                              ),
    ), ], );
    }


  }

  List<Widget> getReviews(String userID) {
    List<Widget> reviews = [];
    
    for (int i = 0; i < data.size; i++) {
      if(widget.restName == data.docs[i]['restaurantID']){
        if(userID == data.docs[i]['studentID']){
          reviews.add(
            Row(
             children: [
               Expanded(
                 child: 
              Card(
                elevation: 5,
                child: UniEatsReviewCard(widget.restName,
                                    data.docs[i]['studentID'],
                                    double.parse("${data.docs[i]['starRating']}"),
                                    data.docs[i]['description']
                                    ).buildCardContent(context),),),
                EditReview(data.docs[i]).build(context),
            ],));
        } else {
          reviews.add(Card(
                elevation: 5,
                child: UniEatsReviewCard(widget.restName,
                                    data.docs[i]['studentID'],
                                    double.parse(data.docs[i]['starRating'].toString()),
                                    data.docs[i]['description']
                                    ).buildCardContent(context),),);
        }
      }
    } 

    return reviews;
  }
}

class EditReview extends StatelessWidget{
  var review;

  EditReview(review): review = review;

  void _showFeedback(context, review) {
    showDialog(
      context: context,
      builder: (context) {
        CollectionReference reviews = FirebaseFirestore.instance.collection("reviews");
  
        return QuickFeedback(
          title: 'Edita a tua Review', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              review['description'] + ' (' + review['starRating'].toString() + ')', // Feedback text field hint text default: Tell us more
          submitText: 'Concluir', // submit button text default: SUBMIT
          onSubmitCallback: (feedback) {
            
            var starRating = (feedback.values.first);
            var userID = StoreProvider.of<AppState>(context).state.content['profile'].email.substring(0,11);
            var description = (jsonDecode(jsonEncode(feedback))['feedback']);
            var restID = review['restaurantID'];
 
            //para editar apagar e adicionar 
            reviews.doc(review.id).delete();

            reviews
              .add({'starRating': starRating, 'description': description, 'restaurantID':restID, 'studentID':  userID})
              .then((value) => print("Review Added"))
              .catchError((error)=> print("Failed to add review"));
            Navigator.of(context).pop();
          },
          askLaterText: 'Apagar Review', 
          onAskLaterCallback: () {
            print('Review Apagada ('+ review.id +') ' + review['description']);
            reviews.doc(review.id).delete();
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
   
    return Container(
      padding: EdgeInsets.only(bottom: 5),
            child: Center(
              child: Card(
                elevation: 5,
              child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
                                        size: 16.0),
                                    onPressed: () => _showFeedback(context, review),
              ),),));
  }

}
class AddReview extends StatelessWidget{

  void _showFeedback(context, restaurantName) {
    showDialog(
      context: context,
      builder: (context) {
  
        return QuickFeedback(
          title: 'Deixa uma Review', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              'Partilha a tua review', // Feedback text field hint text default: Tell us more
          submitText: 'Concluir', // submit button text default: SUBMIT
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
                child: Text('Adicionar Review',style: new TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 0xfa, 0xfa, 0xfa)),),
              ),
            ));
  }

}
