abstract class DataStorage {
  void add(String key, dynamic value);

  dynamic get(String key);

  bool containsKey(String key);

  void remove(String key);
}
