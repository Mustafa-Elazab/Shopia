import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() async {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
       ));
  }

  static Future<Response> getData({
    @required String url,
     Map<String, dynamic> Query,
    String lang = 'en',
    String authorization,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
      'Content-Type': 'application/json',
    };
    return await dio.get(url, queryParameters: Query);
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> Query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String authorization,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
      'Content-Type': 'application/json',
    };

    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    @required String url,
    Map<String, dynamic> Query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String authorization,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
      'Content-Type': 'application/json',
    };

    return await dio.put(url, data: data);
  }

}
