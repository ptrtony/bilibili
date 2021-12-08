import 'dart:io';

import 'package:blibli_app/barrage/barrage_input.dart';
import 'package:blibli_app/utils/hi_constants.dart';
import 'package:blibli_app/widget/barrage_switch.dart';
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
import 'package:blibli_app/widget/video_large_card.dart';
import 'package:blibli_app/widget/video_tool_bar.dart';
import 'package:blibli_app/widget/video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay/flutter_overlay.dart';
import 'package:hi_barrage/hi_barrage.dart';
import 'package:hi_net/core/hi_net_error.dart';

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
  var _barrageKey = GlobalKey<HiBarrageState>();
  bool _inputShowing = false;

  @override
  void initState() {
    super.initState();
    changeStatusBar(color:Colors.black, statusStyle:StatusStyle.LIGHT_CONTENT,context:null);
    _controller = TabController(length: tabs.length, vsync: this);
    this.videoModel = widget.videoMo;
    videoDetailMo = VideoDetailMo(videoInfo: videoModel, videoList: []);
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
                        changeStatusColor: false,
                      ),
                      _buildVideoView(),
                      _buildTabNavigation(context),
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
      barrageUI: HiBarrage(
        key: _barrageKey,
        vid: videoModel.vid,
        autoPlay: true,
        headers: HiConstants.headers(),
      ),
    );
  }

  _buildTabNavigation(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black45,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_tabBar(context), _buildBarrageButton()],
        ),
      ),
    );
  }

  _tabBar(BuildContext context) {
    return HiTab(
      tabs.map<Tab>((tab) {
        return Tab(text: tab);
      }).toList(),
      insets: 15,
      controller: _controller,
      unSelectedLabelColor: Colors.white70,
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
      children: [...buildContents(), ...buildVideoList()],
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
    try {
      var result = await LikeDao.like(videoModel.vid, !videoDetailMo.isLike);
      showToast(result['msg']);
      videoDetailMo.isLike = !videoDetailMo.isLike;
      if (videoDetailMo.isLike) {
        videoModel.like += 1;
      } else {
        videoModel.like -= 1;
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

  ///不喜欢
  void _onUnLike() async {
    if (videoDetailMo.isLike) {
      try {
        var result = await LikeDao.like(videoModel.vid, false);
        showToast(result['msg']);
        videoDetailMo.isLike = false;
        videoModel.like -= 1;
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
  }

  void _onCoin() {}

  ///收藏
  void _onFavorite() async {
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

  buildVideoList() {
    return videoDetailMo.videoList
        .map((videoMo) => VideoLargeCard(videoMo: videoMo));
  }

  _buildBarrageButton() {
    return BarrageSwitch(
      inputShowing: _inputShowing,
      onShowInput: () {
        _inputShowing = true;
        HiOverlay.show(context, child: BarrageInput(
          onTabClose: () {
            setState(() {
              _inputShowing = false;
            });
          },
        )).then((value) {
          print("-----input:$value");
          _barrageKey.currentState.send(value);
        });
      },
      onBarrageSwitch: (open) {
        if(open){
          _barrageKey.currentState.play();
        }else{
          _barrageKey.currentState.pause();
        }
      },
    );
  }
}
