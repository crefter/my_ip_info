import 'dart:convert';

import 'package:my_ip_info/core/app_sp_constants.dart';
import 'package:my_ip_info/features/info/src/data/exception/user_information_not_found_exception.dart';
import 'package:my_ip_info/features/info/src/domain/entity/user_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserInformationDatasource {
  final SharedPreferences _sp;

  LocalUserInformationDatasource({
    required SharedPreferences sp,
  }) : _sp = sp;

  Future<UserInformation> getUserInformation() async {
    final str = _sp.getString(AppSpConstants.userInfoKey);
    if (str == null) {
      throw UserInformationNotFoundException('User not found!');
    }
    final Map<String, dynamic> json = jsonDecode(str);
    UserInformation userInformation = UserInformation.fromJson(json);
    return userInformation;
  }

  Future<void> saveUserInfo(UserInformation userInformation) async {
    final str = jsonEncode(userInformation.toJson());
    await _sp.setString(AppSpConstants.userInfoKey, str);
  }
}
