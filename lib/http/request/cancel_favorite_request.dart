

import 'package:blibli_app/http/request/Favorite_request.dart';
import 'package:hi_net/request/hi_base_request.dart';


class CancelFavoriteRequest extends FavoriteRequest{

  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }

}