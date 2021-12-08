import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/cancel_like_request.dart';
import 'package:blibli_app/http/request/like_request.dart';
import 'package:hi_net/hi_net.dart';

class LikeDao {
  static like(String vid, bool like) async {
    BaseRequest request = like ? LikeRequest() : CancelLikeRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
