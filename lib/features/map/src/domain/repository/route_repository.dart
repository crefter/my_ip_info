import 'package:my_ip_info/features/map/src/domain/entity/route.dart';

abstract interface class RouteRepository {
  Future<Route> getRoute();
  Future<void> saveRoute(Route route);
}