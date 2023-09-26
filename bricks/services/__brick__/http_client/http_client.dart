import 'dart:convert';

import 'package:motor_happy/constants/api_url_constants.dart';
import 'package:motor_happy/service/http_client/http_client.dart';
import 'package:motor_happy/utils/http_logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class HttpClient {
  static String get _baseUrl => URLConstants.baseUrl;

  static late final http.Client _client;

  void init() {
    _client = InterceptedClient.build(
      interceptors: [
        LoggingInterceptor(),
      ],
    );
  }

  final Map<String, String> _headers = Map<String, String>.from(
    {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authorization': AuthConstants.basicAuth,
      "FROM": "app",
    },
  );

  Map<String, String> get getHeaders => Map<String, String>.from(_headers);

  List<String> headerLog = [];

  void addHeader({
    required String key,
    required String value,
  }) {
    _headers[key] = value;
    headerLog.add("$key: $value");
  }

  Future<http.Response> post(
    String endpoint, {
    required String? requestName,
    required Map<String, dynamic> body,
    List<String> excludeHeaders = const [],
  }) async {
    var url = "$_baseUrl/$endpoint";
    return _trackTrace<http.Response>(
      url: url,
      requestMethod: "POST",
      requestName: requestName,
      function: (uri, map) async {
        final subHeaders = Map<String, String>.from(getHeaders);
        subHeaders.removeWhere((key, value) => excludeHeaders.contains(key));
        final response = await _client.post(
          uri,
          headers: subHeaders,
          body: jsonEncode(body),
        );
        map["responseCode"] = response.statusCode;
        return response;
      },
    );
  }

  Future<http.Response> get(
    String endpoint, {
    required String? requestName,
    Map<String, String>? queryParams,
    List<String> excludeHeaders = const [],
  }) async {
    var uri =
        Uri.parse("$_baseUrl/$endpoint").replace(queryParameters: queryParams);
    return _trackTrace(
      url: uri.toString(),
      requestName: requestName,
      requestMethod: "GET",
      function: (_, map) async {
        final subHeaders = Map<String, String>.from(getHeaders);
        subHeaders.removeWhere((key, value) => excludeHeaders.contains(key));
        final response = await _client.get(
          uri,
          headers: subHeaders,
        );
        map["responseCode"] = response.statusCode;
        return response;
      },
    );
  }

  Future<http.Response> put(
    String endpoint, {
    String? requestName,
    required Map<String, dynamic> body,
  }) async {
    var url = "$_baseUrl/$endpoint";
    return _trackTrace<http.Response>(
      url: url,
      requestName: requestName,
      requestMethod: "PUT",
      function: (uri, map) async {
        final response = await _client.put(
          uri,
          headers: getHeaders,
          body: jsonEncode(body),
        );
        map["responseCode"] = response.statusCode;
        return response;
      },
    );
  }

  Future<http.Response> patch(
    String endpoint, {
    String? requestName,
    required Map<String, dynamic> body,
  }) async {
    var url = "$_baseUrl/$endpoint";
    return _trackTrace<http.Response>(
      url: url,
      requestName: requestName,
      requestMethod: "PUT",
      function: (uri, map) async {
        final response = await _client.patch(
          uri,
          headers: getHeaders,
          body: jsonEncode(body),
        );
        map["responseCode"] = response.statusCode;
        return response;
      },
    );
  }

  Future<http.Response> delete(
    String endpoint, {
    String? requestName,
    required Map<String, dynamic> body,
  }) async {
    var url = "$_baseUrl/$endpoint";
    return _trackTrace<http.Response>(
      url: url,
      requestName: requestName,
      requestMethod: "DELETE",
      function: (uri, map) async {
        final response = await _client.delete(
          uri,
          headers: getHeaders,
          body: jsonEncode(body),
        );

        map["responseCode"] = response.statusCode;
        return response;
      },
    );
  }

  Future<T> _trackTrace<T>({
    required String url,
    required String requestMethod,
    required Future<T> Function(Uri uri, Map<dynamic, dynamic> dataMap)
        function,
    required String? requestName,
  }) async {
    // we can do track trace here later
    final dataMap = {};
    final response = await function(Uri.parse(url), dataMap);
    return response;
  }
}
