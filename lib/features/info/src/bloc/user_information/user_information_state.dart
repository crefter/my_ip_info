part of 'user_information_bloc.dart';

@immutable
sealed class UserInformationState {}

class UserInformationInitial extends UserInformationState {}

class UserInformationLoading extends UserInformationState {}

class UserInformationLoaded extends UserInformationState {
  final UserInformation userInformation;

  UserInformationLoaded({
    required this.userInformation,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationLoaded &&
          runtimeType == other.runtimeType &&
          userInformation == other.userInformation;

  @override
  int get hashCode => userInformation.hashCode;
}

class UserInformationError extends UserInformationState {
  final String error;

  UserInformationError({
    required this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInformationError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
