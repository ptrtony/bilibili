

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

///自定义顶部的appBar
appBar(String title,String rightTitle,VoidCallback rightButtonCallback){
  return AppBar(centerTitle: false,
  titleSpacing: 0,
  leading:BackButton(),
  title: Text(
    title,
    style: TextStyle(fontSize: 18),
  ),
  actions: [
    InkWell(
      onTap:rightButtonCallback,
      child: Container(
        padding: EdgeInsets.only(left: 15,right: 15),
        alignment: Alignment.center,
        child: Text(
          rightTitle,
          style: TextStyle(fontSize: 18,color: Colors.grey[500]),
          textAlign: TextAlign.center,
        ),
      ),
    )
  ],
  );
}