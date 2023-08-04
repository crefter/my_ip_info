abstract interface class IpRepository {
  Future<String> getIp();
  Future<void> saveIp();
}