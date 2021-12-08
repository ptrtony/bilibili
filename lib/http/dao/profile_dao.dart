

import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/profile_request.dart';
import 'package:blibli_app/model/profile_mo.dart';
import 'package:hi_net/hi_net.dart';

class ProfileDao{
  static get() async {
    BaseRequest request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return ProfileMo.fromJson(result['data']);
  }
}