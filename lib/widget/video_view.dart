import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/hi_video_controls.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

///播放器组件
class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio; //宽高比
  final Widget overlayUI; //浮层
  const VideoView(this.url,
      {Key key,
      this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    //初始化播放器设置
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: widget.autoPlay,
        aspectRatio: widget.aspectRatio,
        customControls: MaterialControls(
            showLoadingOnInitialize: false,
            showBigPlayIcon: false,
            bottomGradient: blackLinearGradient(),
            overlayUI: widget.overlayUI),
        placeholder: _placeHolder,
        materialProgressColors: _progressColors);
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var displayHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: displayHeight,
      color: Colors.grey,
      child: Chewie(controller: _chewieController),
    );
  }

  get _placeHolder => FractionallySizedBox(
        widthFactor: 1,
        child: cacheImage(widget.cover),
      );

  get _progressColors => ChewieProgressColors(
      playedColor: primary,
      handleColor: primary,
      backgroundColor: Colors.grey,
      bufferedColor: primary[50]);

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
