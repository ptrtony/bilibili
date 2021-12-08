
import 'package:blibli_app/http/request/Favorite_request.dart';
import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/cancel_favorite_request.dart';
import 'package:hi_net/hi_net.dart';

class FavoriteDao{
  static favorite(String vid,bool favorite) async {
    BaseRequest request = favorite?FavoriteRequest():CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}