import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';
import 'package:uni/view/Widgets/terms_and_conditions.dart';

class UniEatsFaqPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UniEatsFaqPageViewState();
}

/// Manages the 'faqs' section of the app.
class UniEatsFaqPageViewState extends UniEatsGeneralPageViewState {
  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return ListView(
      children: <Widget>[
        Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                'FAQs - Preguntas Frequentes',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .apply(fontSizeFactor: 1.3),
              ),
              ),
        Center(
            child: Padding(
          padding: EdgeInsets.only(
              left: queryData.size.width / 12,
              right: queryData.size.width / 12,
              top: queryData.size.width / 12,
              bottom: queryData.size.width / 12),
          child: Column(
            children: uniEatsFaqBody(context), //substituir por about us
          ),
        ))
      ],
    );
  }

  //TODO: Refactor This function for less repetitive code
  List<Widget> uniEatsFaqBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final List<Widget> FaqText = <Widget>[];

    //Initial Phrase
    FaqText.add(
      Container(
        child: Center(
          child: Text(
              'Aqui encontrará resposta para as dúvidas mais frequentes'
              ' dos utilizadores da UniEats!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1),
        ),
      ),
    );

    //TODO: Add FAQs to DB -> automatization

    //Q1
    //TODO: Change color of background to outline
    FaqText.add(
      Container(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        child: Center(
          child: ExpansionTile(
            collapsedBackgroundColor: Color(0xaa791d24),
            title: const Text('Question 1?', style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),),
            children: <Widget>[
            ListTile(title: Text('Answer 1')),
              ],
            ))
          ),
    );

    //Q2
    FaqText.add(
      Container(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        child: Center(
          child: ExpansionTile(
            collapsedBackgroundColor: Color(0xaa791d24),
            title: const Text('Question 2?', style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),),
            children: <Widget>[
            ListTile(title: Text('Answer 2')),
              ],
            ))
          ),
    );

    //Q3
    FaqText.add(
      Container(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        child: Center(
          child: ExpansionTile(
            collapsedBackgroundColor: Color(0xaa791d24),
            title: const Text('Question 3?', style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),),
            children: <Widget>[
            ListTile(title: Text('Answer 3')),
              ],
            ))
          ),
    );

    //Q4
    FaqText.add(
      Container(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        child: Center(
          child: ExpansionTile(
            collapsedBackgroundColor: Color(0xaa791d24),
            title: const Text('Question 4?', style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),),
            children: <Widget>[
            ListTile(title: Text('Answer 4')),
              ],
            ))
          ),
    );

    //Dates
    FaqText.add(
      Container(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, queryData.size.height / 16, 10, 0),
          child: Text('2º Semestre de 2021/2022 - Março/Junho 2022',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2),
        ),
      ),
    );

    return FaqText;
  }
}
