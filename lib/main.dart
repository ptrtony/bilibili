
import 'package:blibli_app/db/hi_cache.dart';
import 'package:blibli_app/http/dao/login_dao.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/home_page.dart';
import 'package:blibli_app/page/login_page.dart';
import 'package:blibli_app/page/registration_page.dart';
import 'package:blibli_app/page/video_detail_page.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:flutter/material.dart';

import 'model/video_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: white,
      ),
      home: LoginPage(),
    );
  }
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _biliRouteDelegate = BiliRouteDelegate();
  // BiliRouteInformationParser _biliRouteInformationParser = BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    //定义widget
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done ?
          Router(routerDelegate: _biliRouteDelegate,) : Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
          return MaterialApp(
            home: widget, theme: ThemeData(primarySwatch: white),);
        });
  }
}


class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //给Navigator设置一个key，必要的时候可以通过navigatorKe.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

  RouteStatus get routeStatus{
    if(_routeStatus != RouteStatus.registration && !hasLogin){
      return _routeStatus = RouteStatus.login;
    }
  }
  BiliRoutePath path;

  bool get hasLogin => LoginDao.getBoardingPass();
  VideoModel videoModel;
  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if(index != -1) {
      //要打开的页面中的栈中存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0,index);
    }
    //构建路由栈
    var page;
    if(routeStatus == RouteStatus.home){
      //跳转首页时将栈中其他页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(HomePage(
        onJumpToDetail: (videoModel){
          this.videoModel = videoModel;
          notifyListeners();
        },
      ));
    }else if(routeStatus == RouteStatus.detail){
      page = pageWrap(VideoDetailPage(videoModel));
    }else if(routeStatus == RouteStatus.registration){
      page = pageWrap(RegistrationPage(toJumpLogin:(){
        _routeStatus = RouteStatus.login;
        notifyListeners();
      }));
    }else if(routeStatus == RouteStatus.login){
      page = pageWrap(LoginPage(jumpToRegistration:(){
        _routeStatus = RouteStatus.registration;
        notifyListeners();
      }));
    }
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        return route.didPop(result);
      },
    );
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
}
