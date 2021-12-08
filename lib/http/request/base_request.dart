import 'package:blibli_app/http/dao/login_dao.dart';
import 'package:blibli_app/utils/hi_constants.dart';
import 'package:hi_net/request/hi_base_request.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    if (needLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    return super.url();
  }

  Map<String, dynamic> header = {
    //访问令牌，在公告栏中去获取
    HiConstants.authTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV
  };
}
