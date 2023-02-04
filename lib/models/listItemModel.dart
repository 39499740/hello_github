/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 23:43:44
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-05 01:03:35
 * @FilePath: /HelloGithub/lib/models/listItemModel.dart
 * @Description: 
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
/*
 * @Author: haoyi 39499740@qq.com
 * @Date: 2023-02-02 23:43:44
 * @LastEditors: haoyi 39499740@qq.com
 * @LastEditTime: 2023-02-02 23:43:47
 * @FilePath: /HelloGithub/lib/models/listItemModel.dart
 * @Description: 列表项数据模型
 * Bilibili 天国的502
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
class ListItemModel {
  String? itemId;
  String? title;
  String? author;
  String? authorAvatar;
  String? name;
  String? description;
  bool? isHot;
  String? primaryLang;
  String? langColor;
  int? clicksTotal;
  int? commentTotal;
  String? updatedAt;

  ListItemModel(
      {this.itemId,
      this.title,
      this.author,
      this.authorAvatar,
      this.name,
      this.description,
      this.isHot,
      this.primaryLang,
      this.langColor,
      this.clicksTotal,
      this.commentTotal,
      this.updatedAt});

  ListItemModel.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    title = json['title'];
    author = json['author'];
    authorAvatar = json['author_avatar'];
    name = json['name'];
    description = json['description'];
    isHot = json['is_hot'];
    primaryLang = json['primary_lang'];
    langColor = json['lang_color'];
    clicksTotal = json['clicks_total'];
    commentTotal = json['comment_total'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['title'] = this.title;
    data['author'] = this.author;
    data['author_avatar'] = this.authorAvatar;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_hot'] = this.isHot;
    data['primary_lang'] = this.primaryLang;
    data['lang_color'] = this.langColor;
    data['clicks_total'] = this.clicksTotal;
    data['comment_total'] = this.commentTotal;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
