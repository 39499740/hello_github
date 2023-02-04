/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-04 21:44:26
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-04 22:29:36
 * @FilePath: /HelloGithub/lib/pages/home/component/homeListItem.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';
import 'package:hello_github/models/listItemModel.dart';
import 'package:intl/intl.dart';

class HomeListItem extends StatelessWidget {
  ListItemModel model;
  Function onTap;
  HomeListItem({Key? key, required this.model, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 20.w),
      decoration: BoxDecoration(
        //半透明灰色分割线
        border: Border(
            bottom: BorderSide(
          color: const Color(0x99999999),
          width: 0.5.w,
        )),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(model.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                decoration: BoxDecoration(
                  color: const Color(0xff60A5FA),
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Text(model.commentTotal.toString(),
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white, height: 1.2)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.w),
            child: Text(model.description ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, color: Colors.black54)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: model.authorAvatar ?? "",
                width: 30.w,
                height: 30.w,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: const Text("·",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black54, height: 1.2)),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Color(int.parse(
                        "0xff${(model.langColor ?? "000000").replaceAll("#", "")}"))),
              ),
              Text(model.primaryLang ?? "",
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black54, height: 1.2)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: const Text("·",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black54, height: 1.2)),
              ),
              Text(
                  TimelineUtil.format(
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .parse((model.updatedAt ?? "2021-01-01 00:00:00")
                              .replaceAll("T", " "))
                          .millisecondsSinceEpoch,
                      locale: "zh",
                      dayFormat: DayFormat.Simple),
                  style: const TextStyle(
                      fontSize: 16, color: Colors.black54, height: 1.2)),
            ],
          )
        ],
      ),
    );
  }
}
