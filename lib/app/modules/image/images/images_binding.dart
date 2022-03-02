import 'package:get/get.dart';

import 'images_logic.dart';

class ImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImagesLogic());
  }
}
