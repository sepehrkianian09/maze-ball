import 'package:get/get.dart';
import 'package:maze_ball/services/level.dart';

class LevelController {
  final _levelService = Get.find<LevelService>();

  void saveLevel(int level) {
    _levelService.saveLevel(level);
  }

  int retrieveLevel() {
    return _levelService.retrieveLevel();
  }

  bool isLevelSaved() {
    return _levelService.isLevelSaved();
  }

  void deleteSavedLevel() {
    return _levelService.deleteSavedLevel();
  }
}
