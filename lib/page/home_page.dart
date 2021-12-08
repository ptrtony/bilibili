import 'package:blibli_app/core/HiState.dart';
import 'package:blibli_app/http/dao/home_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/home_tab_page.dart';
import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/hi_tab.dart';
import 'package:blibli_app/widget/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_net/core/hi_net_error.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int> onJumpTo;

  const HomePage({Key key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin,WidgetsBindingObserver {
  var listener;
  TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance?.removeObserver(this);
    _controller.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
  }

  @override
  Widget build(BuildContext context) {
    _controller = TabController(length: categoryList.length, vsync: this);
    bool isDark = context.watch<ThemeProvider>().isDark();
    return Scaffold(
      body: Column(
        children: [
          NavigationBar(
              height: 50,
              color: isDark ? Colors.black54 : Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
              children: _appBar()),
          Container(
            child: _tabBar(context),
            decoration: bottomBoxShadow(context),
          ),
          Flexible(
              child: TabBarView(
            controller: _controller,
            children: categoryList.map((tab) {
              return HomeTabPage(
                categoryName: tab.name,
                bannerList: tab.name == "推荐" ? bannerList : null,
              );
            }).toList(),
          ))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDark();
    return HiTab(
        categoryList.map<Tab>((tab) {
          return Tab(
            text: tab.name,
          );
        }).toList(),
        controller: _controller,
        unSelectedLabelColor: isDark ? Colors.white70 : Colors.black54,
        fontSize: 16,
        borderWidth: 3,
        insets: 13);
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
      showWarnToast(e.message);
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                  width: 46,
                  height: 46,
                  image: AssetImage('images/avatar.png')),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                HiNavigator.getInstance().onJumpTo(RouteStatus.notice);
              },
              child: Icon(
                Icons.email,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeProvider>().darModeChange();
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(':didChangeAppLifecycleState:$state');
    switch(state){
      case AppLifecycleState.inactive: /// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed:
      //fix Android压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;

    }
  }


}
