import 'package:my_ip_info/features/info/src/data/datasources/local_user_information_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/remote_user_information_datasource.dart';
import 'package:my_ip_info/features/info/src/domain/entity/user_information.dart';
import 'package:my_ip_info/features/info/src/domain/repository/user_information_repository.dart';
import 'package:my_ip_info/features/info/src/service/check_internet_service.dart';

class UserInformationRepositoryImpl implements UserInformationRepository {
  final RemoteUserInformationDatasource _remoteDatasource;
  final LocalUserInformationDatasource _localDatasource;
  final CheckInternetService _checkInternetService;

  UserInformationRepositoryImpl({
    required RemoteUserInformationDatasource remoteDatasource,
    required LocalUserInformationDatasource localDatasource,
    required CheckInternetService checkInternetService,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource,
        _checkInternetService = checkInternetService;

  @override
  Future<UserInformation> getUserInfoByIp(String ip) async {
    if (await _checkInternetService.checkInternet()) {
      return await _remoteDatasource.getUserInformation(ip);
    } else {
      return await _localDatasource.getUserInformation();
    }
  }

  @override
  Future<void> saveUserInfo(UserInformation information) async {
    _localDatasource.saveUserInfo(information);
  }
}
