import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }


class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget children;

  const NavigationBar(
      {Key key,
        this.statusStyle = StatusStyle.DARK_CONTENT,
        this.color = Colors.white,
        this.height = 46,
        this.children})
      : super(key: key);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }


  @override
  Widget build(BuildContext context) {
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.children,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
    );
  }


  void _statusBarInit() {
    changeStatusBar(widget.color,widget.statusStyle);
  }
}

