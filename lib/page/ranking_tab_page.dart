import 'package:blibli_app/core/hi_base_tab_state.dart';
import 'package:blibli_app/http/dao/ranking_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/model/ranking_mo.dart';
import 'package:blibli_app/widget/video_large_card.dart';
import 'package:flutter/material.dart';

class RankingTabPage extends StatefulWidget {
  final String categoryName;

  const RankingTabPage({Key key, this.categoryName}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingMo, VideoMo, RankingTabPage> {
  @override
  get contentChild => ListView.builder(
    physics: AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.only(top: 10),
        itemBuilder: (BuildContext context, int index) =>
            VideoLargeCard(videoMo: dataList[index]),
        controller: scrollController,
        itemCount: dataList.length,
      );

  @override
  Future<RankingMo> getData(int pageIndex) async {
    var result = await RankingDao.get(widget.categoryName, pageIndex, 20);
    return result;
  }

  @override
  List<VideoMo> parseList(RankingMo result) {
    return result.videoList;
  }

  @override
  get centerTitle => null;
}
