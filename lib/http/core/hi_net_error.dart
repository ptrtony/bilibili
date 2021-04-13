
///登录的异常
class NeedLogin extends HiNetError {
  NeedLogin({String message,int errorCode: 401, dynamic data})
      : super(errorCode, message, data: data);
}

///授权的异常
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int errorCode: 403, dynamic data})
      : super(errorCode, message, data: data);
}

class HiNetError implements Exception {
  int errorCode;
  String message;
  dynamic data;

  HiNetError(this.errorCode, this.message, {this.data});
}
