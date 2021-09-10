import 'package:blibli_app/http/core/hi_net.dart';
import 'package:blibli_app/http/request/ranking_request.dart';
import 'package:blibli_app/model/ranking_mo.dart';

class RankingDao {
  static get(String sort, int pageIndex, int pageSize) async {
    var request = RankingRequest();
    request
        .add("sort", sort)
        .add("pageIndex", pageIndex)
        .add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingMo.fromJson(result['data']);
  }
}
