import "dart:convert";
import "package:shared_preferences/shared_preferences.dart";

final class StorageManager {
  late final SharedPreferences _spInstance;
  bool _isInitialized = false;

  /// Call this once during app startup
  Future<void> init() async {
    if (_isInitialized) return;
    _spInstance = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      _spInstance = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  Future<void> saveData(String key, String data) async {
    await _ensureInitialized();
    await _spInstance.setString(key, data);
  }

  Future<void> saveBoolData(String key, bool data) async {
    await _ensureInitialized();
    await _spInstance.setBool(key, data);
  }

  Future<void> saveIntData(String key, int data) async {
    await _ensureInitialized();
    await _spInstance.setInt(key, data);
  }

  Future<void> saveList(String key, List<String> data) async {
    await _ensureInitialized();
    await _spInstance.setStringList(key, data);
  }

  Future<void> saveDynamicList(String key, List<dynamic> data) async {
    await _ensureInitialized();
    final stringList = data.map((item) => jsonEncode(item)).toList();
    await _spInstance.setStringList(key, stringList);
  }

  Future<List<dynamic>> getDynamicList(String key) async {
    await _ensureInitialized();
    final stringList = _spInstance.getStringList(key) ?? [];
    return stringList.map((item) => jsonDecode(item)).toList();
  }

  Future<List<String>?> getList(String key) async {
    await _ensureInitialized();
    return _spInstance.getStringList(key);
  }

  Future<String?> getData(String key) async {
    await _ensureInitialized();
    return _spInstance.getString(key);
  }

  Future<bool> getBoolData(String key, {bool defaultValue = false}) async {
    await _ensureInitialized();
    return _spInstance.getBool(key) ?? defaultValue;
  }

  Future<int?> getIntData(String key) async {
    await _ensureInitialized();
    return _spInstance.getInt(key);
  }

  Future<bool> clearData() async {
    await _ensureInitialized();
    return _spInstance.clear();
  }

  Future<bool> removeData(String key) async {
    await _ensureInitialized();
    return _spInstance.remove(key);
  }
}
