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
