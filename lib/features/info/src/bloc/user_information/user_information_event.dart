part of 'user_information_bloc.dart';

@immutable
sealed class UserInformationEvent {}

class UserInformationLoad extends UserInformationEvent {
  final String ip;

  UserInformationLoad({
    required this.ip,
  });
}
