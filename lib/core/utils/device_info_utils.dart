import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

/// Abstract interface for retrieving device information.
abstract class DeviceInfoUtil {
  Future<String> getDeviceModel();
}

/// A sample implementation using the device_info_plus package.
class DeviceInfoUtilImpl implements DeviceInfoUtil {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  @override
  Future<String> getDeviceModel() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.utsname.machine;
    }
    return 'Unsupported platform';
  }
}
