import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:meta/meta.dart';
import 'package:my_ip_info/features/map/src/domain/repository/route_repository.dart';
import 'package:my_ip_info/features/map/src/exception/geolocation_denied_exception.dart';
import 'package:my_ip_info/features/map/src/exception/geolocation_disabled_exception.dart';
import 'package:my_ip_info/features/map/src/exception/no_internet_exception.dart';
import 'package:my_ip_info/features/map/src/exception/route_not_found_exception.dart';
import 'package:my_ip_info/features/map/src/exception/user_position_not_found_exception.dart';

part 'route_event.dart';

part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository _repository;

  RouteBloc({
    required RouteRepository repository,
  })  : _repository = repository,
        super(RouteInitial()) {
    on<RouteEvent>(
      (event, emit) async => switch (event) {
        RouteLoad() => await _onLoad(event, emit),
      },
    );
  }

  Future<void> _onLoad(
    RouteLoad event,
    Emitter<RouteState> emit,
  ) async {
    emit(RouteLoading());
    try {
      final route = await _repository.getRoute();
      final coords = decodePolyline(route.geometry);
      emit(RouteLoaded(coords: coords, distance: route.distance));
    } on GeolocationDisabledException catch (e) {
      emit(RouteError(message: e.message));
    } on NoInternetException catch (e) {
      emit(RouteError(message: e.message));
    } on GeolocationDeniedException catch (e) {
      emit(RouteError(message: e.message));
    } on UserPositionNotFoundException catch (e) {
      emit(RouteError(message: e.message));
    } on RouteNotFoundException catch (e) {
      emit(RouteError(message: e.message));
    } catch (e) {
      emit(RouteError(message: e.toString()));
    }
  }
}
