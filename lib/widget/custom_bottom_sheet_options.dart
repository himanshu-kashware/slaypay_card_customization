import 'package:flutter/material.dart';
import 'package:get/get.dart';

CustomBottomSheet({required Widget customChild}) {
  Get.bottomSheet(customChild,
      persistent: false,
      ignoreSafeArea: true,
      enableDrag: false,
      elevation: 10,
      isScrollControlled: false,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      )));
}
