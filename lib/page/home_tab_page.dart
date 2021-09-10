import 'package:blibli_app/core/hi_base_tab_state.dart';
import 'package:blibli_app/http/dao/home_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/page/hi_banner.dart';
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

class _HomeTabPageState extends HiBaseTabState<HomeMo, VideoMo, HomeTabPage> {

  @override
  bool get wantKeepAlive => true;


  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: HiBanner(widget.bannerList),
      ),
    );
  }

  @override
  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      crossAxisCount: 2,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 && widget.bannerList != null) {
          return _banner();
        } else {
          return VideoCard(videoMo: dataList[index]);
        }
      },
      staggeredTileBuilder: (int index) {
        if (widget.bannerList != null && index == 0) {
          return StaggeredTile.fit(2);
        } else {
          return StaggeredTile.fit(1);
        }
      });

  @override
  Future<HomeMo> getData(int pageIndex) async {
    var result =
        await HomeDao.get(widget.categoryName, pageIndex: pageIndex, pageSize: 50);
    return result;
  }

  @override
  List<VideoMo> parseList(HomeMo result) {
    return result.videoList;
  }

  @override
  get centerTitle => null;
}
