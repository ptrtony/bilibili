import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/home_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/utils/format_util.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/loading_container.dart';
import 'package:flutter/material.dart';

class RankingTabPage extends StatefulWidget {
  final String categoryName;

  const RankingTabPage({Key key, this.categoryName}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState extends State<RankingTabPage> {
  List<VideoMo> videoList = [];
  int pageIndex = 1;
  bool _load = false;
  bool loading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      if (dis > 300 && !_load) {
        //加载更多
        _load = true;
        _loadData(isLoadMore: true);
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        isLoading: loading,
        child: RefreshIndicator(
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: videoList.map((videoMo) {
                    return _videoCoverView(videoMo);
                  }).toList(),
                )),
            onRefresh: _loadData));
  }

  Future<void> _loadData({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pageIndex = 1;
    }
    int currentPageIndex = pageIndex + (isLoadMore ? 1 : 0);
    try {
      HomeMo result =
          await HomeDao.get(widget.categoryName, pageIndex: currentPageIndex);
      setState(() {
        if (isLoadMore) {
          videoList = [...videoList, ...result.videoList];
          pageIndex++;
        } else {
          videoList = result.videoList;
        }

        setState(() {
          loading = false;
        });
        Future.delayed(Duration(milliseconds: 1000), () {
          _load = false;
        });
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      loading = false;
      _load = false;
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
      loading = false;
      _load = false;
    }
  }

  Widget _videoCoverView(VideoMo videoMo) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, bottom: 10, top: 20),
            child: Row(children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Positioned(
                        child:
                            cacheImage(videoMo.cover, height: 100, width: 160)),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 5, bottom: 5),
                      child: Text(
                        durationTransform(videoMo.duration),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(6)))
                ],
              )
            ])),

        Expanded(child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                videoMo.title,
                style: TextStyle(color: Colors.black, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              border: Border(
                                  left: BorderSide(color: Colors.grey),
                                  top: BorderSide(color: Colors.grey),
                                  right: BorderSide(color: Colors.grey),
                                  bottom: BorderSide(color: Colors.grey))),
                          height: 15,
                          alignment: Alignment.center,
                          child: Text(
                            "UP",
                            style:
                            TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            videoMo.owner.name,
                            style:
                            TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.tv_rounded,
                              color: Colors.grey[400],
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                formatCount(videoMo.reply),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.video_collection_rounded,
                                color: Colors.grey[400],
                                size: 15,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(formatCount(videoMo.like),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.more_vert_rounded,
                        color: Colors.grey[400],
                        size: 15,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        )),
        Container(
            margin: EdgeInsets.only(top: 10),
            child: Divider(height: 1, color: Colors.grey[600]))
      ],
    );
  }
}
