
enum HttpMethod { GET, POST, DELETE }

///基础请求
abstract class HiBaseRequest {
  var pathParams;
  var useHttps = true;

  HttpMethod httpMethod();

  String authority() {
    return "api.devio.org";
  }

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    //拼接Path参数
    if (pathParams != null) {
      if (pathStr.endsWith("/")) {
        pathStr = "$pathStr$pathParams";
      } else {
        pathStr = "$pathStr/$pathParams";
      }
    }
    //http和https的切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    addHeader("course-flag", "fa");
    addHeader("auth-token", "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa");
    print("url:" + uri.toString());
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  ///添加参数
  HiBaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {

  };

  ///添加Header
  HiBaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
