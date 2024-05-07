import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'package:{{name.snakeCase()}}/core/common/services/token.service.dart';
import 'package:{{name.snakeCase()}}/core/config/api.config.dart';
import 'package:{{name.snakeCase()}}/dependencies.dart';
import 'package:{{name.snakeCase()}}/features/auth/domain/repository/auth.repository.interface.dart';

class APIService {
  final Dio _dio = Dio();

  APIService() {
    _dio.options.baseUrl = APIConfig.baseUrl;
    _dio.options.headers.addEntries([
      const MapEntry('Content-Type', 'application/json'),
    ]);
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(printRequestHeaders: true),
      ),
    );
  }

  Dio get dio => _dio;
}

class AuthInterceptor implements InterceptorsWrapper {
  final _tokenService = getIt.get<TokenService>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log(err.message ?? err.toString());
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await getIt.get<AuthRepository>().refreshToken();
      _retry(err.requestOptions);
    } else {
      handler.next(err);
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenService.accessToken;
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return getIt.get<APIService>().dio.request<dynamic>(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: options,
        );
  }
}
