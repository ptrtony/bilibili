import 'package:blibli_app/http/core/dio_adapter.dart';
import 'package:blibli_app/http/core/hi_net_adapter.dart';
import 'package:blibli_app/http/request/base_request.dart';

import 'hi_net_error.dart';

class HiNet {
  HiNet._();

  static HiNet _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse response;
    var error;
    try{
      response = await send(request);
    }on HiNetError catch(e){
      error = e;
      response = e.data;
      printLog(e.message);
    }catch(e){
      //其他异常
      error = e;
      printLog(e);
    }

    if(response == null){
      printLog(error);
    }

    var result = response.data;
    var statusCode = response.statusCode;
    switch(statusCode){
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw HiNetError(statusCode, result.toString(),data:result);
    }
    printLog(result);
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    // printLog('method:${request.httpMethod()}');
    // request.addHeader("token", "123456");
    // printLog('header:${request.header}');
    // return Future.value({
    //   "statesCode": 200,
    //   "data": {"code": 0, "message": "success"}
    // });
    ///使用mock发送数据
    // MockAdapter mockAdapter = MockAdapter();
    //使用dio发送数据
    DioAdapter dioAdapter = DioAdapter();
    return dioAdapter.send(request);
  }



  void printLog(log){
    print("hi_log:" + log.toString());
  }
}
