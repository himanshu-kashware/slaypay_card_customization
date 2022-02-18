import 'package:get/get.dart';

import '../controllers/card_home_controller.dart';

class CardHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardHomeController>(
      () => CardHomeController(),
    );
  }
}
