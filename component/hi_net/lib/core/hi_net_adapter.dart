
import 'dart:convert';

import 'package:hi_net/request/hi_base_request.dart';


///网络请求抽象类
abstract class HiNetAdapter{
  Future<HiNetResponse<T>>send<T>(HiBaseRequest request);
}

///统一网络层返回格式
class HiNetResponse<T>{
  HiNetResponse({this.data, this.request,this.statusCode, this.statusMessage, this.extra});


  T data;


  int statusCode;


  String statusMessage;

  dynamic extra;


  HiBaseRequest request;


  @override
  String toString() {
    if(data is Map){
      return json.encode(data);
    }
    return data.toString();
  }

}