/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 16:24:27
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-05 01:11:24
 * @FilePath: /HelloGithub/lib/pages/tab/tab/provider.dart
 * @Description: Tab状态管理
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:hello_github/providers/global_provider.dart';
import 'package:provider/provider.dart';

class TabProvider extends ChangeNotifier {
  BuildContext context;

  TabProvider(this.context);
  var scaffoldkey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _initialized = false;

  void init() {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () {
        GlobalProvider gp = Provider.of<GlobalProvider>(context, listen: false);
        gp.setup();
      });
    }
  }

  void onTabChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
