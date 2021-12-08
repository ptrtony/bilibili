

import 'package:blibli_app/http/dao/login_dao.dart';

class HiConstants {
  static String authTokenK = "auth-token";
  static String authTokenV = "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa";
  static String courseFlagK = "course-flag";
  static String courseFlagV = "fa";
  static String theme = "theme";


  ///设置请求头校验，注意留意：Console的log输出：flutter:Received:
  static headers() {
    Map<String, dynamic> header = {
      HiConstants.authTokenK: HiConstants.authTokenV,
      HiConstants.courseFlagK: HiConstants.courseFlagV
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }

}
