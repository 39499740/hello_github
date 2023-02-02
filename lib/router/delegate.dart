/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 16:25:48
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 17:04:48
 * @FilePath: /HelloGithub/lib/router/delegate.dart
 * @Description: 路由文件 Navigator2.0
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../pages/tab/tab/view.dart';

class MyRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final List<Page> _pages = [];
  List<Page> get pages => _pages;

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    debugPrint('setNewRoutePath ${configuration.last.name}');

    _setPath(configuration
        .map((routeSettings) => _createPage(routeSettings))
        .toList());
    return Future.value(null);
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);

    // if (_pages.first.name != '/') {
    //   _pages.insert(0, _createPage(const RouteSettings(name: '/')));
    // }
    notifyListeners();
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
      observers: [BotToastNavigatorObserver()],
    );
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmExit();
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    if (canPop()) {
      _pages.removeLast();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: const Text('确定要退出App吗?'),
            actions: [
              TextButton(
                child: const Text('取消'),
                onPressed: () => Navigator.pop(context, true),
              ),
              TextButton(
                child: const Text('确定'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        });
    return result ?? true;
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget child;
    Map<String, dynamic>? argument =
        routeSettings.arguments as Map<String, dynamic>?;
    switch (routeSettings.name) {
      case '/':
        child = TabPage();
        break;
      default:
        child = Scaffold();
    }
    return MaterialPage(
      child: child,
      key: Key(routeSettings.name!) as LocalKey,
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }

  /// 压入新页面显示
  void push({required String name, dynamic arguments}) {
    _pages.add(_createPage(RouteSettings(name: name, arguments: arguments)));
    // 通知路由栈，我们的Page列表已经修改了
    notifyListeners();
  }

  /// 替换当前正在显示的页面
  void replace({required String name, dynamic arguments}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    push(name: name, arguments: arguments);
  }
}
