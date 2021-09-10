


import 'package:blibli_app/http/core/hi_net.dart';
import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/ranking_request.dart';
import 'package:blibli_app/model/favorite_mo.dart';

class MyFavoriteDao{
  static queryFavorite(int pageSize,int pageIndex) async{
    BaseRequest request = RankingRequest();
    request.add("sort", "favorite")
    .add("pageIndex", pageIndex)
    .add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return FavoriteMo.fromJson(result['data']);
  }
}