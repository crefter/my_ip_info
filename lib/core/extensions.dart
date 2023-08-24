import 'package:latlong2/latlong.dart';

extension PolylineExt on List<List<num>> {
  List<LatLng> decodePolylines() => map(
        (e) => LatLng(
          e[0] as double,
          e[1] as double,
        ),
      ).toList();

  LatLng decodeFirstCoordinates() => LatLng(
        this[0][0] as double,
        this[0][1] as double,
      );

  LatLng decodeLastCoordinates() => LatLng(
        this[length - 1][0] as double,
        this[length - 1][1] as double,
      );
}
