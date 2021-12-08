
import 'package:blibli_app/http/request/video_detail_request.dart';
import 'package:blibli_app/model/video_detail_mo.dart';
import 'package:hi_net/hi_net.dart';

class VideoDetailDao{
  static get(String vid) async{
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return VideoDetailMo.fromJson(result["data"]);
  }
}