


import 'home_model.dart';

class FavoriteMo{
  int total;
  List<VideoMo> videoList;

  FavoriteMo({this.videoList});

  FavoriteMo.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      videoList = new List<VideoMo>.empty(growable: true);
      json['list'].forEach((v) {
        videoList.add(new VideoMo.fromJson(v));
      });
    }

    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videoList != null) {
      data['list'] = this.videoList.map((v) => v.toJson()).toList();
    }

    data['total'] = this.total;
    return data;
  }

}