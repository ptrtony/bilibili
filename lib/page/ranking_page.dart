import 'dart:io';

import 'package:blibli_app/page/ranking_tab_page.dart';
import 'package:blibli_app/provider/theme_provider.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/hi_tab.dart';
import 'package:blibli_app/widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    changeStatusBar(color:Colors.black, statusStyle:StatusStyle.LIGHT_CONTENT,context: null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [_buildNavigationBar(context), _buildTabView()])
    );
  }

  _tabBar(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDark();
    return HiTab(
        TABS.map<Tab>((tab) {
          return Tab(text: tab['name']);
        }).toList(),
        fontSize: 16,
        borderWidth: 3,
        insets: 15,
        unSelectedLabelColor: isDark ? Colors.white70 : Colors.black54,
        controller: _controller);
  }

  _buildNavigationBar(BuildContext context) {
    return NavigationBar(
      children: Container(
        alignment: Alignment.center,
        child: _tabBar(context),
        decoration: bottomBoxShadow(context),
      ),
    );
  }

  _buildTabView() {
    return Flexible(
        child: TabBarView(
      children: TABS.map((tab) {
        return RankingTabPage(
          categoryName: tab['key'],
        );
      }).toList(),
      controller: _controller,
    ));
  }
}
