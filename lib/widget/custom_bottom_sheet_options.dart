import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

CustomBottomSheet({required Widget customChild}) {
  Get.bottomSheet(
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
                color: Colors.white,
                child: customChild
            ),
          ),
          CircleAvatar(
              backgroundColor: Colors.white,
              child:   ClipOval(
                child: Material(
                  color: const Color(0xff4B4B4B), // Button color
                  child: InkWell(
                    splashColor: AppColors.accentColor, // Splash color
                    onTap: () {
                      Get.back();
                    },
                    child: const SizedBox(
                        width: 25, height: 25, child: Icon(Icons.clear,color: Colors.white,)),
                  ),
                ),
              ),)
        ],
      ),
      persistent: false,
      ignoreSafeArea: true,
      enableDrag: false,
      elevation: 30,
      isScrollControlled: false,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      )));
}
