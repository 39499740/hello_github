/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 17:18:59
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-05 20:26:34
 * @FilePath: /HelloGithub/lib/pages/home/home/provider.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:flutter/material.dart';
import 'package:hello_github/main.dart';

import 'package:hello_github/models/listItemModel.dart';
import 'package:hello_github/providers/global_provider.dart';
import 'package:hello_github/utils/network.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  BuildContext context;

  HomeProvider(this.context);
  var scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  bool _initialized = false;

  Network network = Network();

  final List<ListItemModel> _itemList = [];
  List<ListItemModel> get itemList => _itemList;

  final EasyRefreshController _easyRefreshController = EasyRefreshController();
  EasyRefreshController get easyRefreshController => _easyRefreshController;

  int _pageNum = 1;

  int _sortIndex = 0;
  int get sortIndex => _sortIndex;

  String _tag = "";
  String get tag => _tag;

  bool _isSearch = false;
  bool get isSearch => _isSearch;

  void init() {
    if (!_initialized) {
      _initialized = true;
      Future.delayed(const Duration(milliseconds: 100), () {
        getList();
      });
    }
  }

  void searchList() async {
    Response? res = await network
        .get("search/", {"q": searchController.text, "page": _pageNum});
    if (res != null) {
      res.data["data"].forEach((v) {
        _itemList.add(ListItemModel.fromJson(v));
      });
      if ((res.data["data"] as List).isEmpty) {
        BotToast.showText(text: "没有更多了");
      }
      _pageNum++;
      notifyListeners();
    } else {
      BotToast.showText(text: "网络错误");
    }
  }

  void getList() async {
    Response? res = await network.get("", {
      "tid": tag,
      "page": _pageNum.toString(),
      "sort_by": _sortIndex == 0 ? "last" : "hot"
    });
    if (res != null) {
      res.data["data"].forEach((v) {
        _itemList.add(ListItemModel.fromJson(v));
      });
      if ((res.data["data"] as List).isEmpty) {
        BotToast.showText(text: "没有更多了");
      }
      _pageNum++;
      notifyListeners();
    } else {
      BotToast.showText(text: "网络错误");
    }
  }

  Future<void> refresh() async {
    _itemList.clear();
    _pageNum = 1;
    if (_isSearch) {
      searchList();
    } else {
      getList();
    }
  }

  Future<void> getMore() async {
    getList();
  }

  void onSubmitted(String value) {
    _isSearch = true;
    _pageNum = 1;
    notifyListeners();
    refresh();
  }

  void closeSearch() {
    _isSearch = false;
    _pageNum = 1;
    notifyListeners();
    refresh();
  }

  void onItemClicked(int index) {
    delegate.push(
        name: "projDetail", arguments: {"itemId": _itemList[index].itemId});
  }

  void onSortChanged(int value) {
    _sortIndex = value;
    refresh();
    notifyListeners();
  }

  void selectTag() async {
    GlobalProvider gp = Provider.of<GlobalProvider>(context, listen: false);
    int? result = await showModalActionSheet<int>(
        context: context,
        materialConfiguration: const MaterialModalActionSheetConfiguration(),
        actions: List.generate(gp.tagList.length + 1, (index) {
          if (index == 0) {
            return const SheetAction(label: "全部", key: 0);
          } else {
            return SheetAction(
                label: gp.tagList[index - 1].name!,
                key: gp.tagList[index - 1].rank!);
          }
        }));
    if (result != null) {
      if (result == 0) {
        _tag = "";
      } else {
        _tag = gp.tagList.firstWhere((element) => element.rank == result).tid!;
      }
      refresh();
      notifyListeners();
    }
  }
}
