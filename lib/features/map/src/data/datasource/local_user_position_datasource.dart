import 'dart:convert';

import 'package:my_ip_info/core/app_sp_constants.dart';
import 'package:my_ip_info/features/map/src/exception/user_position_not_found_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserPositionDatasource {
  final SharedPreferences _sp;

  LocalUserPositionDatasource({
    required SharedPreferences sp,
  }) : _sp = sp;

  Future<(double lat, double lon)> getPosition() async {
    final str = _sp.getString(AppSpConstants.userInfoKey) ?? '';
    if (str.isEmpty) {
      throw UserPositionNotFoundException('User position not found');
    }
    final json = jsonDecode(str);
    return (json['lat'] as double, json['lon'] as double);
  }
}
