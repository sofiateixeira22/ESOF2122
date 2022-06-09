
import 'package:test/test.dart';
import 'package:uni/view/Pages/restaurant_reviews_page.dart';

void main() {
  group('restaurant reviews data', () {
    test('tem asseso a criar + reviews', () async{
      final test1 = ReviewShowerState();

      if(test1.data != null){
        for (int i = 0; i < test1.data.size; i++) {
          if('Grill' == test1.data.docs[i]['restaurantID']){
            if(test1.widget.restName != 'Grill'){
              if(test1.data.docs[i]['studentID'] == 'up201904565'){
        //        expect(test1.build(test1.context).canAdd , false);
              }
            }
          }
          }
      }
    });
    //em progresso
    /*
    test('Exist reviews in restaurant Grill', () {
      final test1 = ReviewShowerState();
      if(test1.widget.restName != 'Grill'){
        expect(test1.widget.reviewsDB,! null);
      }
    });
    */
  });
}