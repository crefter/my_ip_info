part of 'ip_bloc.dart';

@immutable
sealed class IpState {}

class IpInitial extends IpState {}

class IpLoaded extends IpState {
  final String ip;

  IpLoaded({
    required this.ip,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IpLoaded && runtimeType == other.runtimeType && ip == other.ip;

  @override
  int get hashCode => ip.hashCode;
}

class IpError extends IpState {
  final String message;

  IpError({
    required this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IpError &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
