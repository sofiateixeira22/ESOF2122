import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:uni/model/entities/restaurant.dart';

class Arguments {
  final Restaurant restaurant;

  Arguments(this.restaurant);
}

/// Manages the 'schedule' sections of the app
class RestaurantInfoPageView extends StatelessWidget {
  RestaurantInfoPageView({
    Key key,
    @required this.restaurant,
  });

  final Restaurant restaurant;
  final int priceRange = 1; //TODO: add to firebase
  final double starRating = 3.0;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    final Restaurant restaurant =
        ModalRoute.of(context).settings.arguments as Restaurant;

    double sizePrice = 20.0;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('https://sigarra.up.pt/sasup/pt/imagens/SC-alimentacao-grill-engenharia-renovado.jpg'), //TODO: Change to link from DB
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
          height: 300,
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Row(children: [
                  Text(
                    'Preço: ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                .apply(),     
                ),
                  Icon(
                    Icons.euro_symbol_sharp,
                    color: Colors.amber.shade300,
                    size: sizePrice,
                    ),
                  priceRange == 2 || priceRange > 2 ?
                   Icon(
                    Icons.euro_symbol_sharp,
                    color: Colors.amber.shade300,
                    size: sizePrice,
                    ) : Container(width: 0,),
                  priceRange == 3 ?
                    Icon(
                    Icons.euro_symbol_sharp,
                    color: Colors.amber.shade300,
                    size: sizePrice,
                    ) : Container(width: 0,),
                ],),
                    Row(children: [
                      Text(
                    starRating.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                .apply(),     
                ),
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade300,
                    size: sizePrice,
                    ),],),
                    Text('Horário'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Rest_location'),
                    //Botão para ver mapa?
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
