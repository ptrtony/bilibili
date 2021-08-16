import 'package:blibli_app/utils/view_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///自定义顶部的appBar
appBar(String title, String rightTitle, VoidCallback rightButtonCallback) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonCallback,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}


///视频详情页AppBar
videoAppBar() {
  return Container(
    padding: EdgeInsets.only(left: 8),
    decoration: BoxDecoration(
        gradient: blackLinearGradient(fromTop: true)
    ),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          children: [
            Icon(Icons.live_tv_rounded,color: Colors.white),
            Padding(padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.more_vert_rounded,color: Colors.white,),)
          ],
        )
      ],
    ),
  );
}
