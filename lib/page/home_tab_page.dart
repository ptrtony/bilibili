import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/home_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/page/hi_banner.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo> bannerList;

  const HomeTabPage({Key key, this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<VideoMo> videoList = [];
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(left: 10,top: 10,right: 10),
            crossAxisCount: 2,
            itemCount: videoList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0 && widget.bannerList != null) {
                return _banner();
              } else {
                return VideoCard(videoMo: videoList[index]);
              }
            }, staggeredTileBuilder: (int index) {
          if (widget.bannerList != null && index == 0) {
            return StaggeredTile.fit(2);
          } else {
            return StaggeredTile.fit(1);
          }
        }));
  }

  _banner() {
    return Padding(padding: EdgeInsets.only(left: 5, right: 5),

      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: HiBanner(widget.bannerList),
      ),);
  }


  void _loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    int currentPageIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeDao.get(
          widget.categoryName, pageIndex: currentPageIndex, pageSize: 50);
      setState(() {
        if (loadMore) {
          if (result.videoList.isNotEmpty) {
            videoList = [...videoList, ...result.videoList];
            pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

}
