import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final faqsDB = FirebaseFirestore.instance.collection('faqs');

  bool loading = false;
  var data;

@override
  void initState() {
    super.initState();

    fetchFAQData();
  }

  void fetchFAQData() async {
    setState(() {
      loading = true;
    });

    data = await faqsDB.get();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return ListView(
      children: <Widget>[
        Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
              child: Text(
                'Contactos e FAQs',
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
        )),
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
    
    if(loading){
      FaqText.add(Center(child: Text('Loading...'),));
    } else {
        for(int i = 0; i < data.size; i++){
          FaqText.add(
            Container(
              padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
              child: Center(
                child: ExpansionTile(
                  collapsedBackgroundColor:Color.fromARGB(255, 218, 170, 173),
                  title: 
                    Text(data.docs[i]['question'],
                        style: TextStyle(color: Color(0xff000000),
                        fontWeight: FontWeight.bold),),
                  children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 2),
                    title: Text(data.docs[i]['answer'],
                  textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyText2)),
                    ],
                  ))
                ),
    );
        }
    }

    FaqText.add(
       Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text('Necessitas de esclarecimento adicional?\n Contacta-nos através de:',
              textAlign: TextAlign.center,
               style: Theme.of(context).textTheme.bodyText1),
        )
    );

    FaqText.add(
        Container(
          child: Text('unieatsfeup@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        ),);

     //Dates
    FaqText.add(
      Container(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text('2º Semestre de 2021/2022 - Março/Junho 2022',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2
                    .apply(fontSizeFactor: 0.95),
        ),
      ),
    ));

    return FaqText;
  }

  
}
