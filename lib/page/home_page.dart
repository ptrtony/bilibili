import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/dao/home_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/model/video_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/home_tab_page.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
        //onResume();
        print("打开了首页: onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        //onPause();
        print("打开了首页: onPause");
      }
    });

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
  }

  @override
  Widget build(BuildContext context) {
    _controller = TabController(length: categoryList.length, vsync: this);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(
                child: TabBarView(
              controller: _controller,
              children: categoryList.map((tab) {
                return HomeTabPage(
                  name: tab.name,
                  bannerList: tab.name == "推荐" ? bannerList : null,
                );
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: 3),
            insets: EdgeInsets.only(left: 15, right: 15)),
        tabs: categoryList.map<Tab>((tab) {
          return Tab(
            child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  tab.name,
                  style: TextStyle(fontSize: 16),
                )),
          );
        }).toList());
  }

  void loadData() async {
    try {
      HomeMo homeMo = await HomeDao.get("推荐");
      //tab长度发生变化后，需要重新创建TabController
      print(homeMo);
      if (homeMo.categoryList != null && homeMo.categoryList.length > 0) {
        _controller = TabController(length: categoryList.length, vsync: this);
      }
      setState(() {
        categoryList = homeMo.categoryList;
        bannerList = homeMo.bannerList;
      });
    } on NeedLogin catch (e) {
      showToast(e.message);
    }
  }
}
