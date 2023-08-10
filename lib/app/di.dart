import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:my_ip_info/features/info/src/data/datasources/local_ip_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/local_user_information_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/remote_ip_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/remote_user_information_datasource.dart';
import 'package:my_ip_info/features/info/src/data/repository/ip_repository_impl.dart';
import 'package:my_ip_info/features/info/src/data/repository/user_information_repository_impl.dart';
import 'package:my_ip_info/features/info/src/domain/repository/ip_repository.dart';
import 'package:my_ip_info/features/info/src/domain/repository/user_information_repository.dart';
import 'package:my_ip_info/features/info/src/service/check_internet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

DI di = DI();

class DI {
  Dio get dio => Dio();

  late SharedPreferences sp;

  Connectivity get connectivity => Connectivity();

  CheckInternetService get checkInternetService =>
      CheckInternetService(connectivity: connectivity);

  RemoteIpDatasource get remoteIpDatasource => RemoteIpDatasource(dio: dio);

  LocalIpDatasource get localIpDatasource => LocalIpDatasource(sp: sp);

  RemoteUserInformationDatasource get remoteUserInfDatasource =>
      RemoteUserInformationDatasource(dio: dio);

  LocalUserInformationDatasource get localUserInfDatasource =>
      LocalUserInformationDatasource(sp: sp);

  IpRepository get ipRepository => IpRepositoryImpl(
      remoteIpDatasource: remoteIpDatasource,
      localIpDatasource: localIpDatasource,
      checkInternetService: checkInternetService);

  UserInformationRepository get userInformationRepository =>
      UserInformationRepositoryImpl(
          remoteDatasource: remoteUserInfDatasource,
          localDatasource: localUserInfDatasource,
          checkInternetService: checkInternetService);

  DI() {
    SharedPreferences.getInstance().then((value) => sp = value);
  }
}
