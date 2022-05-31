import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/entities/restaurant.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Widgets/meal_slot.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'generic_card.dart';
import 'package:uni/utils/constants.dart' as Constants;

class UniEatsReviewCard extends Card {
  String userID;
  String studentID;
  double starRating;
  String content;

  UniEatsReviewCard(
    String userID,
    String studentID,
    double starRating,
    String content, {
    Key key,
  })  : userID = userID,
        studentID = studentID,
        starRating = starRating,
        content = content,
        super(key: key);

  // UniEatsReviewCard.fromEditingInformation(
  //     Key key, bool editingMode, Function onDelete)
  //     : super.fromEditingInformation(key, editingMode, onDelete);

  Widget buildCardContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(studentID, style: TextStyle(fontSize: 16.0)),
              Row(children: getStarRatingView(context)),
              userID == studentID
                  ? IconButton(
                      icon: Icon(Icons.edit,
                          color: Color.fromARGB(255, 0x75, 0x17, 0x1e),
                          size: 18.0),
                      onPressed: () {
                        print('Edit/Delete Review!');
                        //TODO - EDIT REVIEW USER STORY - include delete from db too
                      })
                  : Container(),
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(5, 12, 5, 5)),
          Text(content),
        ],
      ),
    );
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
}
