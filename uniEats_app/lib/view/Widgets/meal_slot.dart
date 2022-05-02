import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/row_container.dart';

class MealSlot extends StatelessWidget {
  final String type;
  final String name;

  MealSlot({
    Key key,
    @required this.type,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowContainer(
        child: Container(
      padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 22.0, right: 22.0),
      child: createMealSlotRow(context),
    ));
  }

  Widget createMealSlotRow(context) {
    return  Container(
        margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createMealSlotPrimInfo(context),
        ));
  }



  List<Widget> createMealSlotPrimInfo(context) {
    Color color = Theme.of(context).textTheme.headline4.color;
    switch(type){
      case "Vegetariano":
        color = Color.fromARGB(255, 41, 148, 46);
        break;
      // case "Peixe":
      //   color = Colors.cyan;
      //   break;
      // case "Carne":
      //   color = Colors.red;
      //   break;
      default: break;
    }

    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: color,
    );
    final typeTextField = createTextField(
        this.type,
        textStyle,
        TextAlign.center,
        100.0);
    final nameTextField = createTextField(
        "  " + this.name,
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -2),
        TextAlign.center,
        200.0);

    return [
      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              typeTextField,
              nameTextField,
            ],

          ),

        ],
      ),
    ];
  }


  Widget createTextField(text, style, alignment, width) {
    return Container(
      child: 
     Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: style,
      maxLines: 10,
    
    ),
    width: width,
    );
  }

  Widget createScheduleSlotPrimInfoColumn(elements) {
    return Container(child: elements);
  }
}
