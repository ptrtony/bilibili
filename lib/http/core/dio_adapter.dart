import 'package:blibli_app/http/core/hi_net_adapter.dart';
import 'package:blibli_app/http/core/hi_net_error.dart';
import 'package:blibli_app/http/request/base_request.dart';
import 'package:dio/dio.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async{
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response =
            Dio().post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response =
            Dio().delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      ///抛出我们的异常
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(request, response));
    }

    return buildRes(request, response);
  }

  ///构建HiNetResponse
  HiNetResponse buildRes(BaseRequest request, Response response) {
    return HiNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
