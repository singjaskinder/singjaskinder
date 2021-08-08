import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dlivrDriver/models/api_data.dart';
import 'package:dlivrDriver/utils/functions/preferences.dart';

class ApiHandler {
  static const imageBaseUrl =
      'https://storage.googleapis.com/dlivr-55a47.appspot.com/';

  static const _baseUrl = 'http://dlivr.herokuapp.com/';

  static Future<ApiData> getHttp(String endPoint, {String params}) async {
    final authToken = Preferences.getToken();
    params = params == null || params.isEmpty ? '' : '/' + params;
    print('  ::::  ' + _baseUrl + endPoint + params);
    var response = await Dio().get(
      _baseUrl + endPoint + params,
      options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
          contentType: 'application/json'),
    );

    print(response.statusCode.toString() + '  ::::  ' + _baseUrl + endPoint);
    return ApiData(
        data: jsonDecode(jsonEncode(response.data)),
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }

  static Future<ApiData> postHttp(String endPoint, dynamic data,
      {bool isDefault = true, String params}) async {
    final authToken = Preferences.getToken();
    params = params == null || params.isEmpty ? '' : '/' + params;
    print(authToken);
    print(data);
    print('  ::::  ' + _baseUrl + endPoint + params);
    var response = await Dio().post(
      _baseUrl + endPoint + params,
      options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
          contentType: isDefault ? 'application/json' : 'multipart/form-data'),
      data: data,
    );
    print(response.statusCode.toString() + '  ::::  ' + _baseUrl + endPoint);
    return ApiData(
        data: jsonDecode(jsonEncode(response.data)),
        statusCode: response.statusCode,
        statusMessage: response.statusMessage);
  }

  static Future<ApiData> putHttp(String endPoint, dynamic data,
      {bool isDefault = true, String params}) async {
    final authToken = Preferences.getToken();
    params = params == null || params.isEmpty ? '' : '/' + params;
    print(data);
    print('  ::::  ' + _baseUrl + endPoint + params);
    var response = await Dio().put(
      _baseUrl + endPoint + params,
      options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
          contentType: isDefault ? 'application/json' : 'multipart/form-data'),
      data: data,
    );
    print(response.statusCode.toString() + '  ::::  ' + _baseUrl + endPoint);
    return ApiData(
        data: jsonDecode(jsonEncode(response.data)),
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        url: _baseUrl + endPoint);
  }

  static Future<ApiData> deleteHttp(String endPoint, dynamic data,
      {bool isDefault = true, String params}) async {
    final authToken = Preferences.getToken();
    params = params == null || params.isEmpty ? '' : '/' + params;
    print(data);
    print('  ::::  ' + _baseUrl + endPoint + params);
    var response = await Dio().delete(
      _baseUrl + endPoint + params,
      options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
          contentType: isDefault ? 'application/json' : 'multipart/form-data'),
      data: data,
    );
    print(response.statusCode.toString() + '  ::::  ' + _baseUrl + endPoint);
    return ApiData(
        data: jsonDecode(jsonEncode(response.data)),
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        url: _baseUrl + endPoint);
  }
}
