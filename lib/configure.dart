import 'package:get/get.dart';
import 'package:maze_ball/controllers/level.dart';
import 'package:maze_ball/services/level.dart';

import 'dataStorage/hive.dart';
import 'dataStorage/interface.dart';

class Configure {
  Future<void> specify() async {
    final hiveDataStorageInstance = await HiveDataStorage.getInstance();
    Get.lazyPut<DataStorage>(() => hiveDataStorageInstance);

    Get.lazyPut<LevelService>(() => LevelService());

    Get.lazyPut<LevelController>(() => LevelController());
  }
}
