import 'package:blibli_app/core/HiState.dart';
import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/widget/loading_container.dart';
import 'package:flutter/material.dart';

abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  bool load = false;
  bool loading = true;
  ScrollController scrollController = ScrollController();

  get contentChild;

  get centerTitle;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      if (dis < 300 &&
          !load &&
          scrollController.position.maxScrollExtent != 0) {
        load = true;
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return (centerTitle != null)
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                centerTitle,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              centerTitle: true,
            ),
            body: _contentView(context))
        : _contentView(context);
  }

  LoadingContainer _contentView(BuildContext context) {
    return LoadingContainer(
      isLoading: loading,
      child: RefreshIndicator(
        child: MediaQuery.removePadding(
            context: context, removeTop: true, child: contentChild),
        onRefresh: loadData,
        color: primary,
      ),
    );
  }

  ///获取对应页码的数据
  Future<M> getData(int pageIndex);

  ///从MO中解析出list数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    // if (loading) {
    //   print("上次加载还未完成...");
    //   return;
    // }
    // loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    int currentPageIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      var result = await getData(currentPageIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
        loading = false;
      });
      Future.delayed(Duration(microseconds: 1000), () {
        this.load = false;
      });
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
      this.load = false;
      setState(() {
        loading = false;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      this.load = false;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
