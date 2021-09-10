

import 'package:blibli_app/http/core/hi_net.dart';
import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/profile_request.dart';
import 'package:blibli_app/model/profile_mo.dart';

class ProfileDao{
  static get() async {
    BaseRequest request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return ProfileMo.fromJson(result['data']);
  }
}