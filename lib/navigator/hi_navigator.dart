import 'package:blibli_app/navigator/bottom_navigator.dart';
import 'package:blibli_app/page/login_page.dart';
import 'package:blibli_app/page/notice_list_page.dart';
import 'package:blibli_app/page/registration_page.dart';
import 'package:blibli_app/page/video_detail_page.dart';
import 'package:blibli_app/page/dark_mode_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

typedef RouteChangeListener(RouteStatusInfo current,RouteStatusInfo pre);


///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///获取routeStatus的页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    if (getStatus(pages[i]) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///自定义路由封装，路由状态
enum RouteStatus { login, registration, home, detail,notice, unknown ,darkMode}

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else if(page.child is NoticeListPage){
    return RouteStatus.notice;
  }else if(page.child is DarkModePage){
    return RouteStatus.darkMode;
  }
  return RouteStatus.unknown;
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener{
  RouteStatusListener _routeJump;
  List<RouteChangeListener> _listener= [];
  HiNavigator._();
  RouteStatusInfo _current;
  RouteStatusInfo _bottomTab;
  static HiNavigator _instance;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance;
  }


  ///首页底部切换监听
  void onBottomTabChange(int index,Widget page){
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab);
  }

  ///注册路由跳转路基
  void registerRouteJump(RouteStatusListener routeStatusListener) {
    this._routeJump = routeStatusListener;
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener){
    if(!_listener.contains(listener)){
      _listener.add(listener);
    }
  }

  /// 移除监听
  void removeListener(RouteChangeListener listener){
    _listener.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map<dynamic, dynamic> args}) {
    _routeJump.onJumpTo(routeStatus,args:args);
  }

  ///通知路由变化
  void notify(List<MaterialPage> currentPages,List<MaterialPage> prePages){
    if(currentPages == prePages)return;
    var current = RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if(current.page is BottomNavigator && _bottomTab!=null){
      //如果是打开的首页，则明确到首页具体的tab
      current = _bottomTab;
    }
    print("hi_navigator:current:${current.page}");
    print("hi_navigator:pre:${_current?.page}");
    _listener.forEach((listener) {
      listener(current,_current);
    });
    _current = current;
  }

  void openH5(String _url) async{
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  RouteStatusInfo getCurrentPage() {
    return _current;
  }
}

///抽象类供HiNavigator使用
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

///定义路由跳转逻辑要实现的功能
class RouteStatusListener {
  final OnJumpTo onJumpTo;

  RouteStatusListener(this.onJumpTo);
}
