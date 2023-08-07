import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternetService {
  final Connectivity _connectivity;

  CheckInternetService({
    required Connectivity connectivity,
  }) : _connectivity = connectivity;

  Future<bool> checkInternet() async {
    final status = await _connectivity.checkConnectivity();
    return status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi;
  }
}
