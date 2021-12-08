
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

import 'barrage_model.dart';

class HiSocket implements ISocket {
  final Map<String, dynamic> headers;
  static const _URL = "wss://api.devio.org/uapi/fa/barrage/";

  ///心跳间隔时间，根据服务器实际timeout时间调整，这里Nginx服务器的timeout为60
  int _intervalSeconds = 50;
  IOWebSocketChannel _channel;
  ValueChanged<List<BarrageModel>> _callback;

  HiSocket(this.headers);

  @override
  void close() {
    if(_channel != null){
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(callback) {
    _callback = callback;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: headers, pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print("连接发生错误: $error");
    }).listen((event) {
      _handleMessage(event);
    });

    return this;
  }

  @override
  ISocket send(String message) {
    if(_channel != null){
      _channel.sink.add(message);
    }
    return this;
  }


  void _handleMessage(message) {
    print(":" + message);
    var result = BarrageModel.fromJsonString(message);
    if (result != null && _callback != null) {
      _callback(result);
    }
  }

}

abstract class ISocket {
  ///和服务器建立连接
  ISocket open(String vid);

  ///发送弹幕
  ISocket send(String message);

  ///关闭连接
  void close();

  ///接受弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callback);
}
