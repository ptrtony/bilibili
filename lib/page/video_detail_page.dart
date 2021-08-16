import 'dart:io';

import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/favorite_dao.dart';
import 'package:blibli_app/http/dao/like_dao.dart';
import 'package:blibli_app/http/dao/video_detail_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/model/video_detail_mo.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/app_bar.dart';
import 'package:blibli_app/widget/expandable_content.dart';
import 'package:blibli_app/widget/hi_tab.dart';
import 'package:blibli_app/widget/navigation_bar.dart';
import 'package:blibli_app/widget/video_header.dart';
import 'package:blibli_app/widget/video_tool_bar.dart';
import 'package:blibli_app/widget/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoMo videoMo;

  const VideoDetailPage(this.videoMo, {Key key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List tabs = ["简介", "评论12345"];

  VideoDetailMo videoDetailMo;
  VideoMo videoModel;

  @override
  void initState() {
    super.initState();
    changeStatusBar(Colors.black, StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
    this.videoModel = widget.videoMo;
    _loadDetail();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          removeTop: Platform.isIOS,
          context: context,
          child: Container(
            child: videoModel.url != null
                ? Column(
                    children: [
                      NavigationBar(
                        statusStyle: StatusStyle.LIGHT_CONTENT,
                        color: Colors.black,
                        height: Platform.isAndroid ? 0 : 46,
                      ),
                      _buildVideoView(),
                      _buildTabNavigation(),
                      _buildVideoDetailView()
                      // Text("视频详情页，vid${widget.videoMo.vid}"),
                      // Text("视频详情页，标题${widget.videoMo.title}")
                    ],
                  )
                : Container(),
          )),
    );
  }

  _buildVideoView() {
    var videoMo = videoModel;
    return VideoView(
      videoMo.url,
      cover: videoMo.cover,
      overlayUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                size: 20,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((tab) {
        return Tab(text: tab);
      }).toList(),
      insets: 15,
      controller: _controller,
      unSelectedLabelColor: Colors.black45,
    );
  }

  _buildVideoDetailView() {
    return Flexible(
        child: TabBarView(controller: _controller, children: [
      _buildDetailList(),
      Container(
        child: Text("敬请期待"),
      )
    ]));
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: [
        ...buildContents(),
        Container(
          height: 500,
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Text("展开列表"),
        )
      ],
    );
  }

  buildContents() {
    return [
      Container(
        child: VideoHeader(owner: videoModel.owner),
      ),
      ExpandableContent(
        mo: widget.videoMo,
      ),
      VideoToolbar(
        videoDetailMo: videoDetailMo,
        videoMo: videoModel,
        onLike: _doLike,
        onUnLike: _onUnLike,
        onCoin: _onCoin,
        onFavorite: _onFavorite,
        onShare: _onShare,
      )
    ];
  }

  void _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(videoModel.vid);
      setState(() {
        videoDetailMo = result;
        videoModel = result.videoInfo;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      print(e);
      showWarnToast(e.message);
    } catch (e) {
      showWarnToast(e.toString());
    }
  }

  ///喜欢
  void _doLike() async {
    try{
      var result = await LikeDao.like(videoModel.vid, !videoDetailMo.isLike);
      showToast(result['msg']);
      videoDetailMo.isLike = !videoDetailMo.isLike;
      if(videoDetailMo.isLike){
        videoModel.like += 1;
      }else{
        videoModel.like -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
    }on NeedAuth catch(e){
      showWarnToast(e.message);
    }on NeedLogin catch(e){
      showWarnToast(e.message);
    }catch(e){
      showWarnToast(e.toString());
    }
  }

  ///不喜欢
  void _onUnLike() async {
    if(videoDetailMo.isLike){
      try{
        var result = await LikeDao.like(videoModel.vid, false);
        showToast(result['msg']);
        videoDetailMo.isLike = false;
        videoModel.like -=1;
        setState(() {
          videoDetailMo = videoDetailMo;
          videoModel = videoModel;
        });
      }on NeedAuth catch(e){
        showWarnToast(e.message);
      }on NeedLogin catch(e){
        showWarnToast(e.message);
      }catch(e){
        showWarnToast(e.toString());
      }
    }
  }

  void _onCoin() {}

  ///收藏
  void _onFavorite() async{
    try {
      var result =
          await FavoriteDao.favorite(videoModel.vid, !videoDetailMo.isFavorite);
      showToast(result['msg']);
      videoDetailMo.isFavorite = !videoDetailMo.isFavorite;
      if (videoDetailMo.isFavorite) {
        videoModel.favorite += 1;
      } else {
        videoModel.favorite -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } catch (e) {
      showWarnToast(e.toString());
    }
  }

  ///分享
  void _onShare() {}
}
