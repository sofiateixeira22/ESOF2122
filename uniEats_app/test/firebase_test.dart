// ignore_for_file: lines_longer_than_80_chars

import 'package:test/test.dart';
import 'package:uni/view/Widgets/unieats_restaurant_card.dart';

void main() {
  group('recever os dados da firebase', () {
    test('São diferentes que null?', () {
      final test1 = UniEatsRestaurantCardState();
      if(test1.loading && test1.widget.isHomepage){
          var resolte;
          if((resolte = test1.widget.restDB.get() ) != null ){
            expect(resolte, test1.widget.restDB.get());
          }
      }
    });

    test('exist Grill and priceRange correct',() async{
      final test1 = UniEatsRestaurantCardState();
      if(test1.loading && test1.widget.isHomepage){

        var data = await test1.widget.restDB.get();
        for (int i = 0; i < data.size; i++) {
          if(data.docs[i]['name'] == 'Grill'){
            expect(test1.fetchData().priceRange, 1 );
          }
        }
      }

    });

    test('exist Grill and scheduleToday correct',() async{
      final test1 = UniEatsRestaurantCardState();
      if (test1.loading && test1.widget.isHomepage) {
        var data = await test1.widget.restDB.get();
        for (int i = 0; i < data.size; i++) {
          if (data.docs[i]['name'] == 'Grill') {
            if (test1.widget.scheduleList != null) {
              var weekDay = DateTime
                  .now()
                  .weekday - 1;
              String scheduleToday = test1.widget.scheduleList[weekDay];
              if (scheduleToday != 'Fechado' || scheduleToday == null) {
                if (12 < test1
                    .fetchData()
                    .hours && test1
                    .fetchData()
                    .hours > 14) {
                  expect(test1.widget.isOpen, true);
                } else {
                  expect(test1.widget.isOpen, false);
                }
              }
            }
          }
        }
      }
    });
  });
}