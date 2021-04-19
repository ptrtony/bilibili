import 'package:blibli_app/db/hi_cache.dart';
import 'package:blibli_app/http/core/hi_net.dart';
import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/login_request.dart';
import 'package:blibli_app/http/request/registration_request.dart';


//Dao数据访问对象
class LoginDao {

  static const BOARDING_PASS = "boarding-pass";
  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    if(result['code'] == 0 && result['data'] != null){
      //保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass(){
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
