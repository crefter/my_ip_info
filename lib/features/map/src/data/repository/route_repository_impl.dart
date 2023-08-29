import 'package:my_ip_info/core/service/check_internet_service.dart';
import 'package:my_ip_info/features/map/src/data/datasource/local_user_position_datasource.dart';
import 'package:my_ip_info/features/map/src/data/datasource/remote_route_datasource.dart';
import 'package:my_ip_info/features/map/src/domain/entity/route.dart';
import 'package:my_ip_info/features/map/src/domain/repository/route_repository.dart';
import 'package:my_ip_info/features/map/src/exception/geolocation_disabled_exception.dart';
import 'package:my_ip_info/features/map/src/exception/no_internet_exception.dart';
import 'package:my_ip_info/features/map/src/service/geolocator_service.dart';

class RouteRepositoryImpl implements RouteRepository {
  final RemoteRouteDatasource _remoteRouteDatasource;
  final CheckInternetService _checkInternetService;
  final LocalUserPositionDatasource _localUserPositionDatasource;
  final GeolocatorService _geolocatorService;

  RouteRepositoryImpl({
    required RemoteRouteDatasource remoteRouteDatasource,
    required CheckInternetService checkInternetService,
    required LocalUserPositionDatasource localUserPositionDatasource,
    required GeolocatorService geolocatorService,
  })  : _remoteRouteDatasource = remoteRouteDatasource,
        _checkInternetService = checkInternetService,
        _localUserPositionDatasource = localUserPositionDatasource,
        _geolocatorService = geolocatorService;

  @override
  Future<Route> getRoute() async {
    if (!(await _checkInternetService.checkInternet())) {
      throw NoInternetException('No internet connection.\n'
          'Check internet connection and retry.');
    }
    if (!(await _geolocatorService.isServiceEnabled())) {
      throw GeolocationDisabledException('Geolocation service is disabled.\n'
          'Allow geolocation service and retry');
    }
    final (double lat, double lon) ipPosition =
        await _localUserPositionDatasource.getPosition();
    final (double lat, double lon) userPosition =
        await _geolocatorService.getPosition();
    final route = await _remoteRouteDatasource.getRoute(
      userPosition.$1,
      userPosition.$2,
      ipPosition.$1,
      ipPosition.$2,
    );
    return route;
  }
}
