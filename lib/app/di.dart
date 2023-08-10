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
  late Dio dio;

  late SharedPreferences sp;

  late Connectivity connectivity; // Connectivity();

  late CheckInternetService
      checkInternetService; //CheckInternetService(connectivity: connectivity);

  late RemoteIpDatasource remoteIpDatasource; //RemoteIpDatasource(dio: dio);

  late LocalIpDatasource localIpDatasource; // LocalIpDatasource(sp: sp);

  late RemoteUserInformationDatasource remoteUserInfDatasource;

  late LocalUserInformationDatasource localUserInfDatasource;

  late IpRepository ipRepository;

  late UserInformationRepository userInformationRepository;

  Future<void> init() async {
    dio = Dio();
    connectivity = Connectivity();
    checkInternetService = CheckInternetService(connectivity: connectivity);
    sp = await SharedPreferences.getInstance();
    remoteIpDatasource = RemoteIpDatasource(dio: dio);
    localIpDatasource = LocalIpDatasource(sp: sp);
    remoteUserInfDatasource = RemoteUserInformationDatasource(dio: dio);
    localUserInfDatasource = LocalUserInformationDatasource(sp: sp);
    ipRepository = IpRepositoryImpl(
      remoteIpDatasource: remoteIpDatasource,
      localIpDatasource: localIpDatasource,
      checkInternetService: checkInternetService,
    );
    userInformationRepository = UserInformationRepositoryImpl(
      remoteDatasource: remoteUserInfDatasource,
      localDatasource: localUserInfDatasource,
      checkInternetService: checkInternetService,
    );
  }
}
