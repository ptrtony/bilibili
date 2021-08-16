import 'dart:io';

import 'package:blibli_app/page/ranking_tab_page.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/hi_tab.dart';
import 'package:blibli_app/widget/navigation_bar.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"}
  ];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
    changeStatusBar(Colors.black, StatusStyle.LIGHT_CONTENT);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removeViewPadding(
          removeTop: Platform.isIOS,
          context: context,
          child: Column(
            children: [
              Material(
                  elevation: 5,
                  shadowColor: Colors.grey[100],
                  color: Colors.white,
                  child: Column(
                    children: [
                      NavigationBar(
                        statusStyle: StatusStyle.LIGHT_CONTENT,
                        height: Platform.isAndroid ? 0 : 46,
                      ),
                      _tabBar(),
                    ],
                  )),
              Flexible(
                  child: TabBarView(
                      controller: _controller,
                      children: TABS.map((tab) {
                        return RankingTabPage(categoryName: '推荐',);
                      }).toList()))
            ],
          ),
        ));
  }

  _tabBar() {
    return Container(
      alignment: Alignment.center,
      height: 39,
      child: HiTab(
          TABS.map<Tab>((tab) {
            return Tab(text: tab['name']);
          }).toList(),
          fontSize: 16,
          borderWidth: 3,
          insets: 15,
          unSelectedLabelColor: Colors.black54,
          controller: _controller),
    );
  }
}
