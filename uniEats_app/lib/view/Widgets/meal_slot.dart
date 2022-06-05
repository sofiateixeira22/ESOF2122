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
        margin: EdgeInsets.only(top: 1.0, bottom: 1.0, left:1.0, right:1.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return  Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: createMealSlotPrimInfo(context, constraints),
              );
          }
        ),
    );
  }



  List<Widget> createMealSlotPrimInfo(context, constraints) {
    Color color = Theme.of(context).textTheme.headline4.color;
    if(type.contains("Vegetarian")){
        color = Color.fromARGB(255, 41, 148, 46);
    }
    TextStyle textStyle =Theme.of(context).textTheme.headline4;
    textStyle.apply(color: color);

    final typeTextField = createTextField(
        this.type,
        textStyle.apply(fontSizeDelta: -2, color: color, fontSizeFactor: 0.90),
        Alignment.centerLeft,
        constraints.maxWidth/3 -5,
        EdgeInsets.only(right: 5));
    final nameTextField = createTextField(
        this.name,
        textStyle.apply(fontSizeDelta: -2),
        Alignment.centerLeft,
        2*constraints.maxWidth/3 -5,
        EdgeInsets.only(left: 5));

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


  Widget createTextField(text, style, alignment, width, margin) {
    return Container(
      child: 
     Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: style,
      maxLines: 10,
    
    ),
    width: width,
    alignment: alignment,
    margin: margin,
    );
  }

  Widget createScheduleSlotPrimInfoColumn(elements) {
    return Container(child: elements);
  }
}
