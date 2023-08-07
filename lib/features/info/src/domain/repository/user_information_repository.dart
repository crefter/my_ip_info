import 'package:my_ip_info/features/info/src/domain/entity/user_information.dart';

abstract interface class UserInformationRepository {
  Future<UserInformation> getUserInfoByIp(String ip);
  Future<void> saveUserInfo(UserInformation information);
}