/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 16:24:27
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 16:24:50
 * @FilePath: /HelloGithub/lib/pages/tab/tab/provider.dart
 * @Description: Tab状态管理
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */

import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  BuildContext context;

  TabProvider(this.context);
  var scaffoldkey = GlobalKey<ScaffoldState>();

  bool _initialized = false;

  void init() {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () {});
    }
  }
}
