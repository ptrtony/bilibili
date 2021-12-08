
import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/ranking_request.dart';
import 'package:blibli_app/model/favorite_mo.dart';
import 'package:hi_net/hi_net.dart';

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