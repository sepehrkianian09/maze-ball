import 'package:get/get.dart';

import '../dataStorage/interface.dart';

class LevelService {
  final _storage = Get.find<DataStorage>();

  final String _levelKey = "level";

  void saveLevel(int level) {
    _storage.add(_levelKey, level);
  }

  int retrieveLevel() {
    return _storage.get(_levelKey);
  }
}
