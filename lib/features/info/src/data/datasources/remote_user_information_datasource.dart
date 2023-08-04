import 'package:dio/dio.dart';
import 'package:my_ip_info/features/info/src/domain/entity/user_information.dart';

class RemoteUserInformationDatasource {
  final Dio _dio;

  RemoteUserInformationDatasource({
    required Dio dio,
  }) : _dio = dio {
    _dio.options
      ..baseUrl = 'http://ip-api.com/json'
      ..queryParameters = {'fields': '12775167'};
  }

  Future<UserInformation> getUserInformation(String ip) async {
    final result = await _dio.get(ip);
    final UserInformation userInformation =
        UserInformation.fromJson(result.data);
    return userInformation;
  }
}
