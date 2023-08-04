import 'package:my_ip_info/core/app_sp_constants.dart';
import 'package:my_ip_info/features/info/src/data/exception/ip_not_found_in_device_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalIpDatasource {
  final SharedPreferences _sp;

  LocalIpDatasource({
    required SharedPreferences sp,
  }) : _sp = sp;

  Future<String> getIp() async {
    String ip = _sp.getString(AppSpConstants.ipKey) ?? '';
    if (ip.isEmpty) {
      throw IpNotFoundInDeviceException('Ip not found in device!');
    }
    return ip;
  }

  Future<void> saveIp(String ip) async {
    await _sp.setString(AppSpConstants.ipKey, ip);
  }
}
