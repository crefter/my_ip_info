import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_ip_info/features/map/src/domain/entity/route.dart';
import 'package:my_ip_info/features/map/src/exception/route_not_found_exception.dart';

class RemoteRouteDatasource {
  final http.Client _client;

  RemoteRouteDatasource({required http.Client client}) : _client = client;

  Future<Route> getRoute(
    double latFrom,
    double lonFrom,
    double latTo,
    double lonTo,
  ) async {
    try {
      final res = await _client.get(Uri.https('routing.openstreetmap.de',
          'routed-car/route/v1/driving/$lonFrom,$latFrom;$lonTo,$latTo'));
      final body = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> bodyJson = jsonDecode(body);
      if (res.statusCode != 200) {
        throw RouteNotFoundException('Impossible route between points');
      }
      final map = bodyJson['routes'][0];
      final distance = map['distance'] / 1000; // m to km
      final geometry = map['geometry'];
      final Map<String, dynamic> json = {
        'distance': distance,
        'geometry': geometry,
      };
      final route = Route.fromJson(json);
      return route;
    } on NoSuchMethodError catch (_) {
      throw Exception('Something went wrong');
    }
  }
}
