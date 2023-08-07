import 'package:dio/dio.dart';

class RemoteIpDatasource {
  final Dio _dio;

  RemoteIpDatasource({
    required Dio dio,
  }) : _dio = dio {
    dio.options
      ..baseUrl = "https://api.ipify.org"
      ..queryParameters = {'format': 'json'};
  }

  Future<String> getIp() async {
    final result = await _dio.get('');
    final ip = result.data['ip'];
    return ip;
  }
}
