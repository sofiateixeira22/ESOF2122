import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/app_state.dart';
import '../../model/entities/restaurant.dart';
import 'generic_card.dart';

import 'package:uni/utils/constants.dart' as Constants;

class UniEatsHistoryCard extends GenericCard {
  UniEatsHistoryCard({Key key}) : super(key: key);

  UniEatsHistoryCard.fromEditingInformation(
      Key key, bool editingMode, Function onDelete)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  Widget buildCardContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Table(
            columnWidths: {1: FractionColumnWidth(.4)},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 30.0),
                  child: Text('Restaurant2',
                      style: Theme.of(context).textTheme.headline4.apply()),
                ),
                Container(
                  child: IconButton(
                      icon: Icon(Icons.food_bank_sharp),
                      onPressed: () => Navigator.pushNamed(
                            context,
                            '/' + Constants.navRestaurant,
                            arguments: Restaurant(2, 'Cantina', 'ref'),
                          )),
                )
              ]),
              TableRow(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 30.0),
                    child: Text('Restaurant2',
                        style: Theme.of(context).textTheme.headline4.apply()),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.food_bank_sharp),
                        onPressed: () => Navigator.pushNamed(
                              context,
                              '/' + Constants.navRestaurant,
                              arguments: Restaurant(2, 'Cantina', 'ref'),
                            )),
                  )
                ],
              )
            ]),
      ],
    );
  }

  @override
  String getTitle() => 'Histórico';

  @override
  onClick(BuildContext context) {}
}
