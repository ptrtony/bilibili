
import 'package:blibli_app/http/request/base_request.dart';
import 'package:blibli_app/http/request/notice_request.dart';
import 'package:blibli_app/model/notice_mo.dart';
import 'package:hi_net/hi_net.dart';

class NoticeDao{
 
  static get(int pageSize,int pageIndex) async{
    BaseRequest request = NoticeRequest();
    request.add("pageSize", pageSize).add("pageIndex", pageIndex);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return NoticeMo.fromJson(result['data']);
  }
}