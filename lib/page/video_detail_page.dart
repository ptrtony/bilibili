

import 'package:blibli_app/model/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoMo videoMo;

  const VideoDetailPage(this.videoMo,{Key key}) : super(key: key);
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: Container(
      child: Text("视频详情页，vid${widget.videoMo.vid}"),
    ),);
  }
}
