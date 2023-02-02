/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-01 22:07:35
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 17:06:02
 * @FilePath: /HelloGithub/lib/main.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_github/providers/global_provider.dart';
import 'package:hello_github/router/delegate.dart';
import 'package:provider/provider.dart';

MyRouterDelegate delegate = MyRouterDelegate();

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GlobalProvider()),
  ], child: MyApp()));
  if (Platform.isAndroid) {
    // android 状态栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    delegate.push(name: '/');
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light:
          ThemeData(brightness: Brightness.light, colorSchemeSeed: Colors.blue),
      dark: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
          title: 'Adaptive Theme Demo',
          theme: theme,
          darkTheme: darkTheme,
          builder: BotToastInit(),
          home: Router(
            routerDelegate: delegate,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )),
    );
  }
}
