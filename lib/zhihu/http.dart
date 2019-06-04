import 'package:dio/dio.dart';

var dio = Dio(BaseOptions(
  baseUrl: "https://news-at.zhihu.com/api/4/news",
  connectTimeout: 5000,
  receiveTimeout: 5000,
));
