


import 'package:blibli_app/core/hi_base_tab_state.dart';
import 'package:blibli_app/http/dao/notice_dao.dart';
import 'package:blibli_app/model/notice_mo.dart';
import 'package:blibli_app/widget/notice_card.dart';
import 'package:flutter/material.dart';

class NoticeListPage extends StatefulWidget {
  @override
  _NoticeListPageState createState() => _NoticeListPageState();
}

class _NoticeListPageState extends HiBaseTabState<NoticeMo,NoticeModel,NoticeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        _buildNavigationBar(),
        Padding(padding: EdgeInsets.only(top: 10),),
        super.build(context),]
    ),);
  }

  _buildNavigationBar() {
    return AppBar(title:Text( "通知",style: TextStyle(fontSize: 18,color: Colors.black),),centerTitle: true,);
  }

  @override
  get centerTitle => null;

  @override
  get contentChild => ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataList.length,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index){
      return NoticeCardView(noticeMo:dataList[index]);
  });

  @override
  Future<NoticeMo> getData(int pageIndex) async{
    var result = await NoticeDao.get(10, pageIndex);
    return result;
  }

  @override
  List<NoticeModel> parseList(NoticeMo result) {
    return result.list;
  }
}

