/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 16:24:27
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 16:55:48
 * @FilePath: /HelloGithub/lib/pages/tab/tab/view.dart
 * @Description: Tab页面
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TabProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final p = context.read<TabProvider>();
    final pp = Provider.of<TabProvider>(context, listen: true);
    p.init();
    return Scaffold(
        key: p.scaffoldkey,
        body: Container(
          child: Center(
            child: Text('Tab'),
          ),
        ));
  }
}
