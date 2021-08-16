

import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/like_request.dart';

class CancelLikeRequest extends LikeRequest{

  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }
}