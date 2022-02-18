import 'package:get/get.dart';

class CardHomeController extends GetxController {
  //TODO: Implement CardHomeController

  final CardStack= [].obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
