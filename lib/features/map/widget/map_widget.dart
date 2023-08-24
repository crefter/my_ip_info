import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_ip_info/core/extensions.dart';
import 'package:my_ip_info/core/text_style_ext.dart';
import 'package:my_ip_info/features/map/src/bloc/route_bloc.dart';

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
              child: Text(
                message,
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
            ),
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
                      Text('You', style: Theme.of(context).textTheme.header,),
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
            'Distance from you to ip: ${distance.toStringAsFixed(2)} km',
            style: Theme.of(context).textTheme.header,
          ),
        ),
      ],
    );
  }
}
