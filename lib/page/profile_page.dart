
import 'package:blibli_app/http/dao/profile_dao.dart';
import 'package:blibli_app/model/profile_mo.dart';
import 'package:blibli_app/page/hi_banner.dart';
import 'package:blibli_app/utils/toast_util.dart';
import 'package:blibli_app/utils/view_util.dart';
import 'package:blibli_app/widget/benefit_card.dart';
import 'package:blibli_app/widget/course_card.dart';
import 'package:blibli_app/widget/dark_mode_item.dart';
import 'package:blibli_app/widget/hi_blur.dart';
import 'package:blibli_app/widget/hi_flexible_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_net/core/hi_net_error.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _controller;

  ProfileMo _profileMo;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_buildAppBar()];
          },
          body: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 0),
            children: [...buildContentList()],
          )),
    );
  }


  buildContentList() {
    if(_profileMo == null){
      return [];
    }

    return [
      Padding(padding: EdgeInsets.only(top: 10)),
      _buildBannerContent(),
      CourseCard(courseList:_profileMo.courseList),
      BenefitCard(benefitList: _profileMo.benefitList,),
      DarkModeItem()
    ];
  }

  _buildHead() {
    if (_profileMo == null) return Container();
    return HiFlexibleHeader(
        name: _profileMo.name, face: _profileMo.face, controller: _controller);
  }

  void _loadData() async {
    try {
      ProfileMo result = await ProfileDao.get();
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on NeedLogin catch (e) {
      showWarnToast(e.message);
    } catch (e) {
      showWarnToast(e.toString());
    }
  }

  @override
  bool get wantKeepAlive => true;

  _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          children: [
            Positioned.fill(
                child: cacheImage(
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.improve-yourmemory.com%2Fpic%2Fbfb374118777e6a50348c5d2a9041213-3.jpg&refer=http%3A%2F%2Fimg.improve-yourmemory.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632539879&t=2cb78d6b72fe01e4dd3393b2f039426b")),
            Positioned.fill(
                child: HiBlur(
              sigma: 10,
            )),
            Positioned(
                left: 0, right: 0, bottom: 0, child: _buildProfileTabContent())
          ],
        ),
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
      ),
    );
  }

  _buildBannerContent() {
    return HiBanner(
      _profileMo.bannerList,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  _buildProfileTabContent() {
    if (_profileMo == null) return Container();
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      color: Colors.white54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", _profileMo.favorite),
          _buildIconText("点赞", _profileMo.like),
          _buildIconText("浏览", _profileMo.browsing),
          _buildIconText("金币", _profileMo.coin),
          _buildIconText("粉丝", _profileMo.fans)
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$count",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        )
      ],
    );
  }
}
