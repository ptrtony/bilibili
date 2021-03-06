import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/profile_page.dart';
import 'package:blibli_app/page/video_detail_page.dart';
import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/widget/navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'format_util.dart';
import 'package:provider/provider.dart';

///待缓存的image
Widget cacheImage(String url, {double height, double width}) {
  return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      placeholder: (BuildContext context, String url) => Container(
            color: Colors.grey[200],
          ),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          Icon(Icons.error),
      fit: BoxFit.cover);
}

///黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ]);
}

///沉浸式状态栏
changeStatusBar({Color color, StatusStyle statusStyle,BuildContext context}) {
  if(context != null){
    bool isDark = context.watch<ThemeProvider>().isDark();
    if(isDark){
      color = HiColor.dark_bg;
      statusStyle = StatusStyle.LIGHT_CONTENT;
    }
  }

  var page = HiNavigator.getInstance().getCurrentPage()?.page;
  if(page is ProfilePage){
    color = Colors.transparent;
  }else if(page is VideoDetailPage){
    color = Colors.black;
    statusStyle = StatusStyle.LIGHT_CONTENT;
  }
  //沉浸式状态栏样式
  FlutterStatusbarManager.setColor(color, animated: false);
  FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_CONTENT
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
}

///带文字的小图标
smallIconText(IconData iconData, var text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = formatCount(text);
  }
  return [
    Icon(
      iconData,
      size: 12,
      color: Colors.grey,
    ),
    Text(
      " $text",
      style: style,
    )
  ];
}

///分割线
borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide = BorderSide(color: Colors.grey[200], width: 0.5);
  return Border(
      top: top ? borderSide : BorderSide.none,
      bottom: bottom ? borderSide : BorderSide.none);
}

///间距
hiSpace({double height: 1, double width: 1}) {
  return SizedBox(height: height, width: width);
}

///底部阴影
BoxDecoration bottomBoxShadow(BuildContext context) {
  bool isDark = context.watch<ThemeProvider>().isDark();
  return BoxDecoration(color: isDark ? Colors.black : Colors.white, boxShadow: [
    BoxShadow(
        color: isDark ? Colors.black12 : Colors.grey[100],
        offset: Offset(0, 5), //xy轴偏移
        blurRadius: 5.0, //阴影模糊程度
        spreadRadius: 1) //阴影扩散程度
  ]);
}
