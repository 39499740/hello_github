/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 17:18:59
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-05 01:23:30
 * @FilePath: /HelloGithub/lib/pages/home/home/view.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';
import 'package:hello_github/pages/home/component/homeListItem.dart';
import 'package:hello_github/providers/global_provider.dart';
import 'package:hello_github/r.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import 'provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final p = context.read<HomeProvider>();
    final pp = Provider.of<HomeProvider>(context, listen: true);
    GlobalProvider gpp = Provider.of<GlobalProvider>(context, listen: true);
    p.init();

    return Scaffold(
      key: p.scaffoldkey,
      body: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 110.w),
                    width: double.infinity,
                    height: 110.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialSegmentedControl(
                          children: const {
                            0: Text("     最新     "),
                            1: Text("最热"),
                          },
                          verticalOffset: 10.w,
                          selectedColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          unselectedColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          selectionIndex: pp.sortIndex,
                          onSegmentChosen: (value) => p.onSortChanged(value),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              p.selectTag();
                            },
                            child: Text(pp.tag == ""
                                ? "全部"
                                : gpp.tagList
                                    .firstWhere(
                                        (element) => element.tid == pp.tag)
                                    .name!))
                      ],
                    ),
                  ),
                  Expanded(
                      child: EasyRefresh(
                    header: const BezierHeader(),
                    footer: const BezierFooter(),
                    onRefresh: () async => {await p.refresh()},
                    onLoad: () async => {await p.getMore()},
                    child: ListView.builder(
                      itemCount: pp.itemList.length,
                      itemBuilder: (context, index) {
                        return HomeListItem(
                            model: pp.itemList[index],
                            onTap: () {
                              p.onItemClicked(pp.itemList[index]);
                            });
                      },
                    ),
                  ))
                ],
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: SearchBarAnimation(
        textEditingController: pp.searchController,
        isOriginalAnimation: true,
        enableKeyboardFocus: true,
        onExpansionComplete: () {
          debugPrint('do something just after searchbox is opened.');
        },
        onCollapseComplete: () {
          debugPrint('do something just after searchbox is closed.');
        },
        onPressButton: (isSearchBarOpens) {
          debugPrint(
              'do something before animation started. It\'s the ${isSearchBarOpens ? 'opening' : 'closing'} animation');
        },
        trailingWidget: Image.asset(
          R.assetsImagesLogo,
          width: 20,
          height: 20,
          fit: BoxFit.cover,
        ),
        secondaryButtonWidget: const Icon(
          Icons.close,
          size: 20,
          color: Colors.black,
        ),
        buttonWidget: const Icon(
          Icons.search,
          size: 20,
          color: Colors.black,
        ),
        onFieldSubmitted: (value) {
          pp.onSubmitted(value);
        },
      ),
    );
  }

  Widget _typeButton(String title, int index, HomeProvider p, HomeProvider pp) {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: ElevatedButton(child: Text(title), onPressed: () {}),
    );
  }
}
