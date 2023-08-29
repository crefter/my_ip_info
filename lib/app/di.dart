import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:my_ip_info/core/service/check_internet_service.dart';
import 'package:my_ip_info/features/info/src/data/datasources/local_ip_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/local_user_information_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/remote_ip_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/remote_user_information_datasource.dart';
import 'package:my_ip_info/features/info/src/data/repository/ip_repository_impl.dart';
import 'package:my_ip_info/features/info/src/data/repository/user_information_repository_impl.dart';
import 'package:my_ip_info/features/info/src/domain/repository/ip_repository.dart';
import 'package:my_ip_info/features/info/src/domain/repository/user_information_repository.dart';
import 'package:my_ip_info/features/map/src/data/datasource/local_user_position_datasource.dart';
import 'package:my_ip_info/features/map/src/data/datasource/remote_route_datasource.dart';
import 'package:my_ip_info/features/map/src/data/repository/route_repository_impl.dart';
import 'package:my_ip_info/features/map/src/domain/repository/route_repository.dart';
import 'package:my_ip_info/features/map/src/service/geolocator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

DI di = DI();

class DI {
  late Dio dio;

  late http.Client client;

  late SharedPreferences sp;

  late Connectivity connectivity;

  late CheckInternetService checkInternetService;

  late RemoteIpDatasource remoteIpDatasource;

  late LocalIpDatasource localIpDatasource;

  late RemoteUserInformationDatasource remoteUserInfDatasource;

  late LocalUserInformationDatasource localUserInfDatasource;

  late IpRepository ipRepository;

  late UserInformationRepository userInformationRepository;

  late RemoteRouteDatasource remoteRouteDatasource;

  late LocalUserPositionDatasource localUserPositionDatasource;

  late GeolocatorService geolocatorService;

  late RouteRepository routeRepository;

  Future<void> init() async {
    dio = Dio();
    client = http.Client();
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
    remoteRouteDatasource = RemoteRouteDatasource(client: client);
    localUserPositionDatasource = LocalUserPositionDatasource(sp: sp);
    geolocatorService = GeolocatorService();
    routeRepository = RouteRepositoryImpl(
      remoteRouteDatasource: remoteRouteDatasource,
      checkInternetService: checkInternetService,
      localUserPositionDatasource: localUserPositionDatasource,
      geolocatorService: geolocatorService,
    );
  }
}
