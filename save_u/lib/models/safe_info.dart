class SafeInfo {
  int? id;
  String? title;
  String? content;
  int? scrap;
  String? link;
  int? subCategoryId;

  SafeInfo(
      {this.id,
      this.title,
      this.content,
      this.scrap,
      this.link,
      this.subCategoryId});

  factory SafeInfo.fromJson(Map<String, dynamic> json) => SafeInfo(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      scrap: json['scrap'],
      link: json['link'],
      subCategoryId: json['subCategoryId']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'scrap': scrap,
        'link': link,
        'subCategoryId': subCategoryId
      };
  safeInfoMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['title'] = title!;
    mapping['content'] = content!;
    mapping['scrap'] = scrap ?? 1;
    mapping['link'] = link!;
    mapping['subCategoryId'] = subCategoryId ?? null;
    return mapping;
  }
}
