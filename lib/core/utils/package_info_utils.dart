import 'package:package_info_plus/package_info_plus.dart';

/// Utility class for retrieving package/app information.
class PackageInfoUtil {
  /// Retrieves the current app version as a string.
  static Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// Retrieves the full package information as a [PackageInfo] object.
  static Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
