import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementer implements NetworkInfo {
  final Connectivity _dataConnectionChecker;

  NetworkInfoImplementer(this._dataConnectionChecker);

  @override
  Future<bool> get isConnected async {
    final result = await _dataConnectionChecker.checkConnectivity();

    final isWifiConnected = result == ConnectivityResult.wifi;
    final isConnected = result != ConnectivityResult.none;

    return isConnected && isWifiConnected;
  }

  @override
  String toString() => 'NetworkInfoImplementer(_dataConnectionChecker: $_dataConnectionChecker)';

  @override
  bool operator ==(covariant NetworkInfoImplementer other) {
    if (identical(this, other)) return true;

    return other._dataConnectionChecker == _dataConnectionChecker;
  }

  @override
  int get hashCode => _dataConnectionChecker.hashCode;
}
