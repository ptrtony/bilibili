

import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/widget/video_view.dart';
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
      child: Column(
        children: [
          Text("视频详情页，vid${widget.videoMo.vid}"),
          Text("视频详情页，标题${widget.videoMo.title}"),
          _videoView()
        ],
      ),

    ),);
  }

  _videoView() {
    var videoMo = widget.videoMo;
    return VideoView(videoMo.url,cover: videoMo.cover);
  }
}
