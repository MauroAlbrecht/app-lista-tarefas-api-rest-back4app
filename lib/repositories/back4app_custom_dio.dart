import 'package:app_tarefas_back4app/repositories/back4app_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4appCustomDio {

  final _dio = Dio();

  get dio => _dio;

  Back4appCustomDio() {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = dotenv.get('BASE_URL');
    _dio.interceptors.add(Back4appDioInterceptor());
  }
}
