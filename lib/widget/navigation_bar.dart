import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget children;
  final bool changeStatusColor;
  const NavigationBar(
      {Key key,
        this.statusStyle = StatusStyle.DARK_CONTENT,
        this.color = Colors.white,
        this.height = 46,
        this.children, this.changeStatusColor = true})
      : super(key: key);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  Color _color;
  StatusStyle _statusStyle;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    bool isDark = context.watch<ThemeProvider>().isDark();
    if(isDark){
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    }else{
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusBarInit(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.children,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }


  void _statusBarInit(BuildContext context) {
    changeStatusBar(color:_color,statusStyle:_statusStyle,context: context);
  }
}

