import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract interface for connectivity utilities.
abstract class ConnectivityUtil {
  /// Returns true if the device is connected to a network.
  Future<bool> isConnected();

  /// Provides a stream that emits connectivity status changes.
  Stream<bool> get connectivityStream;
}

/// A sample implementation using the connectivity_plus package.
class ConnectivityUtilImpl implements ConnectivityUtil {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Stream<bool> get connectivityStream => _connectivity.onConnectivityChanged
      .map((result) => result != ConnectivityResult.none);
}
