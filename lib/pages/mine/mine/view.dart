/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 17:19:18
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 17:20:23
 * @FilePath: /HelloGithub/lib/pages/mine/mine/view.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MineProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final p = context.read<MineProvider>();
    final pp = Provider.of<MineProvider>(context, listen: true);
    p.init();
    return Scaffold(
      key: p.scaffoldkey,
      body: Center(
        child: Text("MinePage"),
      ),
    );
  }
}
