import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/unieats_gen_page_view.dart';

/// Generic class implementation for the uniEats user's personal pages view.
abstract class UniEatsNoDrawerPageView extends UniEatsGeneralPageViewState {
  @override
  getScaffold(BuildContext context, Widget body) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: this.refreshState(context, body),
    );
  }
}
