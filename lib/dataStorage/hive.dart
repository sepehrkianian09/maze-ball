import 'interface.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveDataStorage implements DataStorage {
  static HiveDataStorage? _instance;

  static Future<HiveDataStorage> getInstance() async {
    if (_instance == null) {
      await Hive.initFlutter();
      await Hive.openBox("storage");
      _instance = HiveDataStorage._(Hive.box("storage"));
    }
    return _instance as HiveDataStorage;
  }

  final Box _storage;

  HiveDataStorage._(this._storage);

  @override
  void add(String key, value) {
    _storage.put(key, value);
  }

  @override
  bool containsKey(String key) {
    return _storage.containsKey(key);
  }

  @override
  get(String key) {
    return _storage.get(key);
  }

  @override
  void remove(String key) {
    _storage.delete(key);
  }
}
