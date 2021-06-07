
// ///登录的异常
// class NeedLogin extends HiNetError {
//   NeedLogin({String message,int errorCode: 401, dynamic data})
//       : super(errorCode, message, data: data);
// }
//
// ///授权的异常
// class NeedAuth extends HiNetError {
//   NeedAuth(String message, {int errorCode: 403, dynamic data})
//       : super(errorCode, message, data: data);
// }
//
// class HiNetError implements Exception {
//   int errorCode;
//   String message;
//   dynamic data;
//
//   HiNetError(this.errorCode, this.message, {this.data});
// }


///需要登录的异常
class NeedLogin extends HiNetError {
  NeedLogin({int code: 401, String message: '请先登录'}) : super(code, message);
}

///需要授权的异常
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message, data: data);
}

///网络异常统一格式类
class HiNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HiNetError(this.code, this.message, {this.data});
}
