import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_ip_info/features/info/src/domain/repository/ip_repository.dart';
import 'package:my_ip_info/features/info/src/exception/ip_not_found_in_device_exception.dart';

part 'ip_event.dart';

part 'ip_state.dart';

class IpBloc extends Bloc<IpEvent, IpState> {
  final IpRepository _ipRepository;

  IpBloc({required IpRepository ipRepository})
      : _ipRepository = ipRepository,
        super(IpInitial()) {
    on<IpEvent>(
      (event, emit) async => switch (event) {
        IpLoad() => await _onLoad(event, emit),
      },
    );
  }

  Future<void> _onLoad(IpLoad event, Emitter<IpState> emit) async {
    try {
      final ip = await _ipRepository.getIp();
      emit(IpLoaded(ip: ip));
      await _ipRepository.saveIp(ip);
    } on IpNotFoundInDeviceException catch (e) {
      emit(IpError(message: e.message));
    } catch (e) {
      emit(IpError(message: 'Unknown error'));
    }
  }
}
