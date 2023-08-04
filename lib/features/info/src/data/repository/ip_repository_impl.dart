import 'package:my_ip_info/features/info/src/data/datasources/local_ip_datasource.dart';
import 'package:my_ip_info/features/info/src/data/datasources/remote_ip_datasource.dart';
import 'package:my_ip_info/features/info/src/domain/repository/ip_repository.dart';
import 'package:my_ip_info/features/info/src/service/check_internet_service.dart';

class IpRepositoryImpl implements IpRepository {
  final RemoteIpDatasource remoteIpDatasource;
  final LocalIpDatasource localIpDatasource;
  final CheckInternetService checkInternetService;

  IpRepositoryImpl({
    required this.remoteIpDatasource,
    required this.localIpDatasource,
    required this.checkInternetService,
  });

  @override
  Future<String> getIp() async {
    if (await checkInternetService.checkInternet()) {
      return await remoteIpDatasource.getIp();
    } else {
      return await localIpDatasource.getIp();
    }
  }

  @override
  Future<void> saveIp(String ip) async {
    await localIpDatasource.saveIp(ip);
  }
}
