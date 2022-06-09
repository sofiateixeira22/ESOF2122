import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';

class UniEatsAboutPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UniEatsAboutPageViewState();
}

/// Manages the 'about' section of the app.
class UniEatsAboutPageViewState extends UniEatsGeneralPageViewState {
  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return ListView(
        key: const Key('uniEats_SobreNos_page'),
        children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SvgPicture.asset(
              'assets/images/eats_logo_dark.svg',
              color: Theme.of(context).accentColor,
              width: queryData.size.height / 7,
              height: queryData.size.height / 7,
            )),
        Center(
            child: Padding(
          padding: EdgeInsets.only(
              left: queryData.size.width / 12,
              right: queryData.size.width / 12,
              top: queryData.size.width / 12,
              bottom: queryData.size.width / 12),
          child: Column(
            children: uniEatsAboutUsText(context), //substituir por about us
          ),
        ))
      ],
    );
  }

  //TODO: Refactor This function for less repetitive code
  List<Widget> uniEatsAboutUsText(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final List<Widget> aboutText = <Widget>[];

    //Initial Phrase
    aboutText.add(
      Container(
        child: Center(
          child: Text(
              'App desenvolvida por estudantes do 3ºAno da LEIC@FEUP'
              ' para a U.C. de Engenharia de Software (ES)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1),
        ),
      ),
    );

    //Group Members
    aboutText.add(
      Container(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Center(
          child: Text(
            'Equipa 3LEIC02T4: ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );

    aboutText.add(Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text('Ana Matilde Guedes Perez da Silva Barra',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1),
    ));

    aboutText.add(Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text('Ana Rita Antunes Ramada',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1),
    ));

    aboutText.add(Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text('Maria Sofia Diogo Figueiredo',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1),
    ));

    aboutText.add(Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text('Pedro Manuel Bernardo Azevedo',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1),
    ));

    aboutText.add(Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Text('Ana Sofia de Castro Teixeira',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1),
    ));

    //Dates
    aboutText.add(
      Container(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, queryData.size.height / 6, 10, 0),
          child: Text('2º Semestre de 2021/2022 - Março/Junho 2022',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2),
        ),
      ),
    );

    return aboutText;
  }
}
