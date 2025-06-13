import "package:shared_preferences/shared_preferences.dart";

final class StorageManager {
  late final SharedPreferences _spInstance;
  static const String token = "token";
  bool _isInitialized = false;

  Future<void> setSPInstance() async {
    if (_isInitialized) return;
    _spInstance = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  Future<void> saveData(String key, String data) async =>
      await _spInstance.setString(key, data);

  Future<void> saveBoolData(String key, bool data) async =>
      await _spInstance.setBool(key, data);

  Future<void> saveIntData(String key, int data) async =>
      await _spInstance.setInt(key, data);

  Future<void> saveList(String key, List<String> data) async =>
      await _spInstance.setStringList(key, data);

  Future<List<String>?> getList(String key) async =>
      _spInstance.getStringList(key);

  Future<String?> getData(String key) async => _spInstance.getString(key);

  Future<bool> getBoolData(
    String key, {
    final bool defaultValue = false,
  }) async => _spInstance.getBool(key) ?? false;

  Future<int?> getIntData(String key) async => _spInstance.getInt(key);

  Future<bool> clearData() async => _spInstance.clear();

  Future<bool> removeData(String key) async => _spInstance.remove(key);
}
