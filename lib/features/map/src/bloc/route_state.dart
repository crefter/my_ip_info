part of 'route_bloc.dart';

@immutable
sealed class RouteState {}

class RouteInitial extends RouteState {}

class RouteLoading extends RouteState {}

class RouteLoaded extends RouteState {
  final List<List<num>> coords;
  final double distance;

  RouteLoaded({
    required this.coords,
    required this.distance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteLoaded &&
          runtimeType == other.runtimeType &&
          coords == other.coords &&
          distance == other.distance;

  @override
  int get hashCode => coords.hashCode ^ distance.hashCode;
}

class RouteError extends RouteState {
  final String message;

  RouteError({
    required this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
