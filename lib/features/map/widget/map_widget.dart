import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_ip_info/core/extensions.dart';
import 'package:my_ip_info/core/text_style_ext.dart';
import 'package:my_ip_info/core/theme_widget.dart';
import 'package:my_ip_info/features/map/src/bloc/route_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, state) {
        return switch (state) {
          RouteLoaded(
            coords: var coords,
            distance: var distance,
          ) =>
            _FlutterMap(coords: coords, distance: distance),
          RouteError(message: var message) => Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RouteBloc>().add(RouteLoad());
                    },
                    child: Text(AppLocalizations.of(context).retry),
                  ),
                ],
              ),
            ),
          _ => const CircularProgressIndicator.adaptive(),
        };
      },
    );
  }
}

class _FlutterMap extends StatelessWidget {
  const _FlutterMap({
    required this.coords,
    required this.distance,
  });

  final List<List<num>> coords;
  final double distance;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(
              coords[0][0] as double,
              coords[0][1] as double,
            ),
            zoom: 10,
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'zarechnev.max.my_ip_info',
                tileBuilder: (context, tileWidget, tile) {
                  return ValueListenableBuilder(
                    builder: (context, themeMode, child) {
                      return themeMode == ThemeMode.light
                          ? tileWidget
                          : ColorFiltered(
                              colorFilter: const ColorFilter.matrix(
                                <double>[
                                  -1.0, 0.0, 0.0, 0.0, 255.0, //
                                  0.0, -1.0, 0.0, 0.0, 255.0, //
                                  0.0, 0.0, -1.0, 0.0, 255.0, //
                                  0.0, 0.0, 0.0, 1.0, 0.0, //
                                ],
                              ),
                              child: tileWidget,
                            );
                    },
                    valueListenable: ThemeWidget.of(context).themeMode,
                  );
                }),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: coords.decodePolylines(),
                  strokeWidth: 5.0,
                  color: Colors.redAccent,
                )
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  width: 50,
                  height: 65,
                  point: coords.decodeFirstCoordinates(),
                  builder: (ctx) => Column(
                    children: [
                      Text(
                        appLocalizations.you,
                        style: Theme.of(context).textTheme.header,
                      ),
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.green,
                        size: 36,
                      ),
                    ],
                  ),
                ),
                Marker(
                  anchorPos: AnchorPos.align(AnchorAlign.top),
                  width: 50,
                  height: 65,
                  point: coords.decodeLastCoordinates(),
                  builder: (ctx) => Column(
                    children: [
                      Text('Ip', style: Theme.of(context).textTheme.header),
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.red,
                        size: 36,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            appLocalizations.distance(distance.toStringAsFixed(2)),
            style: Theme.of(context).textTheme.header,
          ),
        ),
      ],
    );
  }
}
