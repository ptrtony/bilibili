

import 'package:blibli_app/model/video_model.dart';
import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/home_tab_page.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin , TickerProviderStateMixin{
  var listener;
  var tabs = ["推荐","热门","追播","影视","搞笑","日常","综合","手机游戏","短片·手书·配乐"];
  TabController _controller;
  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre){
      if(widget == current.page || current.page is HomePage){
        //onResume();
        print("打开了首页: onResume");
      }else if(widget == pre?.page || pre?.page is HomePage){
        //onPause();
        print("打开了首页: onPause");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
  }


  @override
  Widget build(BuildContext context) {

    _controller = TabController(length: tabs.length, vsync: this);


    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(child: TabBarView(
              controller: _controller,
              children: tabs.map((tab){
                return HomeTabPage(name: tab,);
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: primary,width: 3),
          insets: EdgeInsets.only(left: 15,right: 15)
        ),
        tabs: tabs.map<Tab>((tab){
          return Tab(child: Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child:Text(tab,style: TextStyle(fontSize: 16),)),);
        }).toList()
    );
  }
}
