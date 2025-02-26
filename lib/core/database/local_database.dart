abstract class LocalDatabase {
  /// Initializes the database.
  Future<void> init();

  /// Saves a string value for the given key.
  Future<void> saveString(String key, String value);

  /// Retrieves a string value for the given key.
  Future<String?> getString(String key);

  /// Removes the value for the given key.
  Future<void> remove(String key);

  // --- CRUD for User ---

  /// Saves a user object represented as a Map.
  Future<void> setUser(Map<String, dynamic> user);

  /// Retrieves the stored user as a Map.
  Future<Map<String, dynamic>?> getUser();

  /// Removes the stored user.
  Future<void> removeUser();
}
