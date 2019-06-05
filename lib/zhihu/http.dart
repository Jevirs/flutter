import 'package:dio/dio.dart';

class API {
  static Dio dio = Dio(BaseOptions(
    baseUrl: "https://news-at.zhihu.com/api/4/news",
    connectTimeout: 5000,
    receiveTimeout: 5000,
  ));

  get(String url) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print('error: ============>' + e.toString());
      return e; //continue
    }));
    return dio.get(url);
  }
}
