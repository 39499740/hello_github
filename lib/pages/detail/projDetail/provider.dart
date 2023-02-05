import 'package:flutter/material.dart';

class ProjDetailProvider extends ChangeNotifier {
  BuildContext context;
  String itemId;

  ProjDetailProvider(this.context, this.itemId);
  var scaffoldkey = GlobalKey<ScaffoldState>();

  bool _initialized = false;

  void init() {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () {});
    }
  }
}
