/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 16:10:28
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-05 20:19:07
 * @FilePath: /HelloGithub/lib/providers/global_provider.dart
 * @Description: 全局状态管理
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_github/models/tagModel.dart';
import 'package:hello_github/utils/network.dart';

class GlobalProvider with ChangeNotifier {
  List<TagModel> _tagList = [];
  List<TagModel> get tagList => _tagList;

  String _mobKey = "";
  String get mobKey => _mobKey;

  Network network = Network();

  //获取Tag
  Future<void> getTagList() async {
    _tagList.clear();

    Response? res =
        await network.get("tag/", {"pageSize": 15, "sort_by": "rank"});
    if (res != null) {
      res.data["data"].forEach((v) {
        _tagList.add(TagModel.fromJson(v));
      });
      //根据rank排序
      _tagList.sort((a, b) => (a.rank!).compareTo(b.rank!));
      notifyListeners();
    } else {
      BotToast.showText(text: "标签获取失败");
    }
  }

  //获取移动端域名key
  Future<void> getMobileKey() async {
    Dio dio = Dio();
    Response? res = await dio.get("https://hellogithub.com/");
    int index = res.data.indexOf("/_buildManifest.js");
    String key = res.data.substring(0, index).split("/").last;
    _mobKey = key;
    notifyListeners();
  }

  void setup() {
    getTagList();
    getMobileKey();
  }
}
