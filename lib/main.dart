import 'package:blibli_app/db/hi_cache.dart';
import 'package:blibli_app/http/dao/login_dao.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:blibli_app/navigator/bottom_navigator.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/home_page.dart';
import 'package:blibli_app/page/login_page.dart';
import 'package:blibli_app/page/notice_list_page.dart';
import 'package:blibli_app/page/registration_page.dart';
import 'package:blibli_app/page/video_detail_page.dart';
import 'package:blibli_app/provider/hi_provider.dart';
import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/video_model.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _biliRouteDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    //定义widget
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(
                  routerDelegate: _biliRouteDelegate,
                )
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return MultiProvider(
            providers: topProvider,
            child: Consumer<ThemeProvider>(builder: (BuildContext context,
                ThemeProvider themeProvider, Widget child) {
              return MaterialApp(
                home: widget,
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
              );
            }),
          );
        });
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //给Navigator设置一个key，必要的时候可以通过navigatorKe.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteStatusListener((RouteStatus routeStatus, {Map args}) {
      this._routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        this.videoMo = args["videoMo"];
      }
      notifyListeners();
    }));
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoMo != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  BiliRoutePath path;

  bool get hasLogin => LoginDao.getBoardingPass() != null;
  VideoMo videoMo;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面中的栈中存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    //构建路由栈
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其他页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoMo));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    } else if (routeStatus == RouteStatus.notice) {
      page = pageWrap(NoticeListPage());
    }
    tempPages = [...tempPages, page];
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
        //fix Android物理返回键的问题，无法返回到上一页问题
        onWillPop: () async => !await navigatorKey.currentState.maybePop(),
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            //登录页未登录返回拦截
            if (route.settings is MaterialPage) {
              if ((route.settings as MaterialPage).child is LoginPage &&
                  !hasLogin) {
                showWarnToast("请先登录");
                return false;
              }
            }
            //执行返回操作
            if (!route.didPop(result)) {
              return false;
            }
            //返回上一页出栈操作
            var tempPages = pages;
            pages.removeLast();
            //通知路由发生变化
            HiNavigator.getInstance().notify(pages, tempPages);
            return true;
          },
        ));
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {
    this.path = path;
  }
}

///
class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    print("uri:$uri");
    if (uri.pathSegments.length == 0) {
      return BiliRoutePath.home();
    }
    return BiliRoutePath.detail();
  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";

  BiliRoutePath.notice() : location = "/notice";
}
