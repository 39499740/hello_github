/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 22:09:08
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 22:38:26
 * @FilePath: /HelloGithub/lib/utils/network.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

class Network {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "https://api.hellogithub.com/v1/",
    connectTimeout: 5000,
  ));

  factory Network() => _getInstance();

  static Network get instance => _getInstance();
  static Network? _instance;

  Network._internal();
  static Network _getInstance() {
    _instance ??= Network._internal();
    return _instance!;
  }

  Future<Response?> get(String path, Map<String, dynamic> body) async {
    BotToast.showLoading();
    try {
      Response res = await dio.get(
        path,
        queryParameters: body,
      );
      BotToast.closeAllLoading();
      return res;
    } on DioError catch (e) {
      BotToast.closeAllLoading();

      if (e.response != null) {
        return e.response;
      }
      BotToast.showText(text: e.toString());
      return null;
    }
  }
}
