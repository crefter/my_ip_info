import 'package:auto_route/annotations.dart';
import 'package:auto_route/src/route/auto_route_config.dart';
import 'package:my_ip_info/app/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          children: [
            AutoRoute(path: '', page: InfoRoute.page),
            AutoRoute(path: 'map', page: MapRoute.page),
          ],
        ),
      ];
}
