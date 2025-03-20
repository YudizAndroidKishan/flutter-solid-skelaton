import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'local_database.dart';
import 'database_keys.dart';

class HiveDatabase implements LocalDatabase {
  static const String _boxName = 'appBox';
  Box? _box;

  HiveDatabase() {
    init();
  }

  @override
  Future<void> init() async {
    // Initialize Hive with the application's document directory.
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Open (or create) a box for storing key-value pairs.
    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> saveString(String key, String value) async {
    if (_box == null) await init();
    await _box!.put(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    if (_box == null) await init();
    return _box!.get(key) as String?;
  }

  @override
  Future<void> remove(String key) async {
    if (_box == null) await init();
    await _box!.delete(key);
  }

  @override
  Future<void> setUser(Map<String, dynamic> user) async {
    if (_box == null) await init();
    await _box!.put(DatabaseKeys.user, user);
  }

  @override
  Future<Map<String, dynamic>?> getUser() async {
    if (_box == null) await init();
    final storedUser = _box!.get(DatabaseKeys.user);
    if (storedUser is Map) {
      // In case the stored map's type is not exactly Map<String, dynamic>,
      // you might need to cast it accordingly.
      return Map<String, dynamic>.from(storedUser);
    }
    return null;
  }

  @override
  Future<void> removeUser() async {
    if (_box == null) await init();
    await _box!.delete(DatabaseKeys.user);
    await removeToken();
  }

  @override
  Future<void> saveToken(String token) async {
    if (_box == null) await init();
    await saveString(DatabaseKeys.token, token);
  }

  @override
  Future<void> removeToken() async {
    if (_box == null) await init();
    await remove(DatabaseKeys.token);
  }

  @override
  String? getToken() {
    return _box?.get(DatabaseKeys.token) as String?;
  }
}
