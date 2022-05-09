import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/app_state.dart';
import 'generic_card.dart';

class UniEatsStatsCard extends GenericCard {
  UniEatsStatsCard({Key key}) : super(key: key);

  UniEatsStatsCard.fromEditingInformation(
      Key key, bool editingMode, Function onDelete)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  Widget buildCardContent(BuildContext context) {
    //TODO: Tirar hardcoded
    String nReviews = (0).toString(); 
    String nAddMeal = (0).toString(); 

    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Table(
            columnWidths: {1: FractionColumnWidth(.4)},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20.0),
                  child: Text('Número de Reviews: ',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .apply()),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 30.0),
                  child: Text(nReviews, style: Theme.of(context)
                          .textTheme
                          .headline4
                          .apply()))
              ]),
              TableRow(children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20.0),
                  child: Text('Número de contribuições: ',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .apply()),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 30.0),
                  child: Text(nAddMeal, style: Theme.of(context)
                          .textTheme
                          .headline4
                          .apply()))
              ])
            ]),
      ],
    );
  }

  @override
  String getTitle() => 'Estatísticas';

  @override
  onClick(BuildContext context) {}
}
