import 'package:flutter/material.dart';
import '../../utils/constants.dart' as Constants;

class UniEatsNavigationDrawer extends StatefulWidget {
  final BuildContext parentContext;

  UniEatsNavigationDrawer({@required this.parentContext}) {}

  @override
  State<StatefulWidget> createState() {
    return UniEatsNavigationDrawerState(parentContext: parentContext);
  }
}

class UniEatsNavigationDrawerState extends State<UniEatsNavigationDrawer> {
  final BuildContext parentContext;

  UniEatsNavigationDrawerState({@required this.parentContext}) {}

  Map drawerItems = {};

  @override
  void initState() {
    super.initState();

    drawerItems = {
      Constants.navUniEats: _onSelectPage,
      Constants.navFavourites: _onSelectPage,
      Constants.navHistory: _onSelectPage,
      Constants.navUniEatsAbout: _onSelectPage,
      Constants.navPersonalArea: _onSelectPage,
    };
  }

  // Callback Functions
  getCurrentRoute() => ModalRoute.of(parentContext).settings.name == null
      ? drawerItems.keys.toList()[0]
      : ModalRoute.of(parentContext).settings.name.substring(1);

  _onSelectPage(String key) {
    final prev = getCurrentRoute();

    Navigator.of(context).pop();

    if (prev != key) {
      Navigator.pushNamed(context, '/' + key);
    }
  }

  _onLogOut(String key) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/' + key, (Route<dynamic> route) => false);
  }

  // End of Callback Functions

  Decoration _getSelectionDecoration(String name) {
    return (name == getCurrentRoute())
        ? BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Theme.of(context).accentColor, width: 3.0)),
            color: Theme.of(context).dividerColor,
          )
        : null;
  }

  Widget createLogoutBtn() {
    return OutlinedButton(
      onPressed: () => _onLogOut(Constants.navLogOut),
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(0.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Text(Constants.navLogOut,
            style: Theme.of(context)
                .textTheme
                .headline6
                .apply(color: Theme.of(context).accentColor)),
      ),
    );
  }

  Widget createDrawerNavigationOption(String d) {
    String toWrite = d;

    if(d == Constants.navPersonalArea){
      toWrite = 'Voltar à uni';
    }
    else if (d == Constants.navUniEatsAbout){
      toWrite = 'Sobre Nós';
    }

    return Container(
        decoration: _getSelectionDecoration(d),
        child: ListTile(
          title: Container(
            padding: EdgeInsets.only(bottom: 3.0, left: 20.0),
            child: Text(toWrite,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.normal)),
          ),
          dense: true,
          contentPadding: EdgeInsets.all(0.0),
          selected: d == getCurrentRoute(),
          onTap: () => drawerItems[d](d),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> drawerOptions = [];

    for (var key in drawerItems.keys) {
      drawerOptions.add(createDrawerNavigationOption(key));
    }

    return Drawer(
        child: Column(
      children: <Widget>[
        Expanded(
            child: Container(
          padding: EdgeInsets.only(top: 55.0),
          child: ListView(
            children: drawerOptions,
          ),
        )),
        Row(children: <Widget>[Expanded(child: createLogoutBtn())])
      ],
    ));
  }
}
