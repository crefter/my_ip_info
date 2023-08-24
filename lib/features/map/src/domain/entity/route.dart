class Route {
  final double distance;
  final String geometry;

  Route({
    required this.distance,
    required this.geometry,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Route &&
          runtimeType == other.runtimeType &&
          distance == other.distance &&
          geometry == other.geometry;

  @override
  int get hashCode => distance.hashCode ^ geometry.hashCode;

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      distance: json['distance'],
      geometry: json['geometry'],
    );
  }
}
