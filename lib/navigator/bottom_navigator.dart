import 'package:blibli_app/navigator/hi_navigator.dart';
import 'package:blibli_app/page/favorite_page.dart';
import 'package:blibli_app/page/home_page.dart';
import 'package:blibli_app/page/profile_page.dart';
import 'package:blibli_app/page/ranking_page.dart';
import 'package:blibli_app/utils/color.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final defaultColor = Colors.grey;
  final activeColor = primary;
  int _currentIndex = 0;
  static int initialPage = 0;
  final PageController _pageController =
      PageController(initialPage: initialPage);
  List<Widget> pages;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    pages = [HomePage(), RankingPage(), FavoritePage(), ProfilePage()];
    if (!_hasBuild) {
      //页面第一次打开时通知打开的是那个tab
      HiNavigator.getInstance()
          .onBottomTabChange(initialPage, pages[initialPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: activeColor,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('排行', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.live_tv, 3)
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: activeColor,
        ),
        label: title);
  }

  _onJumpTo(int index, {bool pageChange = false}) {
    //让PageView展示对应的Tab
    if (!pageChange) {
      _pageController.jumpToPage(index);
    }else{
      HiNavigator.getInstance().onBottomTabChange(index, pages[index]);
    }
    setState(() {
      //控制选中的第一个tab
      _currentIndex = index;
    });
  }
}
