import 'package:blibli_app/core/hi_base_tab_state.dart';
import 'package:blibli_app/http/dao/my_favorite_dao.dart';
import 'package:blibli_app/model/favorite_mo.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/widget/video_large_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState
    extends HiBaseTabState<FavoriteMo, VideoMo, FavoritePage> {
  @override
  get contentChild => ListView.builder(
        itemCount: dataList.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return VideoLargeCard(
            videoMo: dataList[index],
          );
        },
        controller: scrollController,
      );

  @override
  Future<FavoriteMo> getData(int pageIndex) async {
    var result = await MyFavoriteDao.queryFavorite(10, pageIndex);
    return result;
  }

  @override
  List<VideoMo> parseList(FavoriteMo result) {
    return result.videoList;
  }

  @override
  get centerTitle => "收藏";
}
