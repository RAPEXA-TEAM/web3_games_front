import 'package:dio/dio.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';

class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('\n');
    print(
        '--> ${options.method} ${'' + (options.baseUrl) + (options.path)}');
    print('Headers:');

    options.headers.addAll({
      "Authorization": "Bearer " + SharedStore.getUserToken(),
      "email": SharedStore.getUserEmail()
    });

    options.headers.forEach((k, dynamic v) => print('$k: $v'));
    print('queryParameters:');
    options.queryParameters.forEach((k, dynamic v) => print('$k: $v'));
    if (options.data != null) {
      print('Body: ${options.data}');
    }
    print(
        '--> END ${options.method}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('\n\n');
    print(
        '<--- HTTP CODE : ${response.statusCode} URL : ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    print('Headers: ');
    printWrapped('Response : ${response.data}');
    print('<--- END HTTP');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('\n');
    print(
        '<-- ${err.message} ${err.response?.requestOptions.method != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL'}');
    print(
        '${err.response != null ? err.requestOptions.data : 'Unknown Error'}');
    print('<-- End error');
    super.onError(err, handler);
  }

  void printWrapped(String text) {
    final RegExp pattern = RegExp('.{1,800}');
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}
