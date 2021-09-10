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
        body: Column(
          children: [
            _buildNavigationBar(),
            _buildTabView()
          ],
        ));
  }

  _tabBar() {
    return HiTab(
        TABS.map<Tab>((tab) {
          return Tab(text: tab['name']);
        }).toList(),
        fontSize: 16,
        borderWidth: 3,
        insets: 15,
        unSelectedLabelColor: Colors.black54,
        controller: _controller);
  }

  _buildNavigationBar() {
    return NavigationBar(
      children: Container(
        alignment: Alignment.center,
        child: _tabBar(),
        decoration: bottomBoxShadow(),
      ),
    );
  }

  _buildTabView() {
    return Flexible(child: TabBarView(children: TABS.map((tab){
      return RankingTabPage(categoryName: tab['key'],);
    }).toList(),controller: _controller,));
  }
}
