import 'package:my_ip_info/features/info/src/data/exception/ip_not_found_in_device_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteIpDatasource {
  static const _ipKey = 'ip';
  final SharedPreferences sp;

  RemoteIpDatasource({
    required this.sp,
  });

  Future<String> getIp() async {
    String ip = sp.getString(_ipKey) ?? '';
    if (ip.isEmpty) {
      throw IpNotFoundInDeviceException('Ip not found in device!');
    }
    return ip;
  }

  Future<void> saveIp(String ip) async {
    await sp.setString(_ipKey, ip);
  }
}
