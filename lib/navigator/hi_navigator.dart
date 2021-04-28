import 'package:blibli_app/page/home_page.dart';
import 'package:blibli_app/page/login_page.dart';
import 'package:blibli_app/page/registration_page.dart';
import 'package:blibli_app/page/video_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
enum RouteStatus { login, registration, home, detail, unknown }

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }
  return RouteStatus.unknown;
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget widget;

  RouteStatusInfo(this.routeStatus, this.widget);
}
