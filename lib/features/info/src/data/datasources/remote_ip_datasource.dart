import 'package:dio/dio.dart';

class RemoteIpDatasource {
  final Dio dio;

  RemoteIpDatasource({
    required this.dio,
  }) {
    dio.options
      ..baseUrl = "https://api.ipify.org"
      ..queryParameters = {'format': 'json'};
  }

  Future<String> getIp() async {
    final result = await dio.get('');
    final ip = result.data['ip'];
    return ip;
  }
}
