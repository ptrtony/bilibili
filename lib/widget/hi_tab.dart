
import 'package:blibli_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

///顶部tab切换
class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unSelectedLabelColor;

  const HiTab(this.tabs, {Key key,this.controller, this.fontSize = 16, this.borderWidth = 3, this.insets = 15, this.unSelectedLabelColor = Colors.grey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: primary,
        unselectedLabelColor: unSelectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize,color: Colors.black87),
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: borderWidth),
            insets: EdgeInsets.only(left: insets, right: insets)),
        tabs: tabs);
  }
}
