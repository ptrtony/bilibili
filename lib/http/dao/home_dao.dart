
import 'package:blibli_app/http/request/home_request.dart';
import 'package:blibli_app/model/home_model.dart';
import 'package:hi_net/hi_net.dart';

class HomeDao {
  static get(String categoryName,{int pageIndex = 1, int pageSize = 20}) async {
    HomeRequest homeRequest = new HomeRequest();
    homeRequest.pathParams = categoryName;
    homeRequest.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(homeRequest);
    print(result);
    return HomeMo.fromJson(result["data"]);
  }
}
