class DataModel {
  String? title;
  String? content;
  String? img_src;

  DataModel({this.title, this.content});

  DataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['description'];
    img_src = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = content;
    data['img'] = img_src;
    return data;
  }
}
