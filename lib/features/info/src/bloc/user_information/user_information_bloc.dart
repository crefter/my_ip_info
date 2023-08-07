import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_ip_info/features/info/src/domain/entity/user_information.dart';
import 'package:my_ip_info/features/info/src/domain/repository/user_information_repository.dart';
import 'package:my_ip_info/features/info/src/exception/user_information_not_found_exception.dart';

part 'user_information_event.dart';

part 'user_information_state.dart';

class UserInformationBloc
    extends Bloc<UserInformationEvent, UserInformationState> {
  final UserInformationRepository _userInformationRepository;

  UserInformationBloc({required UserInformationRepository repository})
      : _userInformationRepository = repository,
        super(UserInformationInitial()) {
    on<UserInformationEvent>((event, emit) async => switch (event) {
          UserInformationLoad() => await _onLoad(event, emit),
        });
  }

  Future<void> _onLoad(
    UserInformationLoad event,
    Emitter<UserInformationState> emit,
  ) async {
    emit(UserInformationLoading());
    try {
      final UserInformation userInformation =
          await _userInformationRepository.getUserInfoByIp(event.ip);
      emit(UserInformationLoaded(userInformation: userInformation));
      await _userInformationRepository.saveUserInfo(userInformation);
    } on UserInformationNotFoundException catch (e) {
      emit(UserInformationError(error: e.message));
    } catch (e) {
      emit(UserInformationError(error: e.toString()));
    }
  }
}
