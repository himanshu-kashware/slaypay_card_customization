
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CustomBottomSheet({required Widget customChild}){

  Get.bottomSheet(
      customChild,
      enableDrag: false,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )
      )

  );
}