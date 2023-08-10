import 'package:dio/dio.dart';

class RemoteIpDatasource {
  final Dio _dio;

  RemoteIpDatasource({
    required Dio dio,
  }) : _dio = dio;

  Future<String> getIp() async {
    _dio.options
      ..baseUrl = "https://api.ipify.org"
      ..queryParameters = {'format': 'json'};
    final result = await _dio.get('');
    final ip = result.data['ip'];
    return ip;
  }
}
