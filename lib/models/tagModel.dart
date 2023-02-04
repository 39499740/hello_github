class TagModel {
  String? name;
  String? tid;
  String? iconName;
  int? rank;
  bool? isShow;
  int? repoTotal;
  String? createdAt;
  String? updatedAt;

  TagModel(
      {this.name,
      this.tid,
      this.iconName,
      this.rank,
      this.isShow,
      this.repoTotal,
      this.createdAt,
      this.updatedAt});

  TagModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tid = json['tid'];
    iconName = json['icon_name'];
    rank = json['rank'];
    isShow = json['is_show'];
    repoTotal = json['repo_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tid'] = this.tid;
    data['icon_name'] = this.iconName;
    data['rank'] = this.rank;
    data['is_show'] = this.isShow;
    data['repo_total'] = this.repoTotal;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
