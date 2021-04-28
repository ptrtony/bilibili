


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarnToast(String text){
  Fluttertoast.showToast(msg: text,gravity: ToastGravity.CENTER,backgroundColor: Colors.red,textColor:Colors.white,toastLength: Toast.LENGTH_SHORT);
}

void showToast(String text){
  Fluttertoast.showToast(msg: text,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER);
}