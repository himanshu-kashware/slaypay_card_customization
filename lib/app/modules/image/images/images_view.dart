import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:slaypay_cc/app/modules/card_home/controllers/card_home_controller.dart';

class ImagesComponent extends GetView<CardHomeController> {
  const ImagesComponent({
    Key? key,
    this.image,
  }) : super(key: key);

  final String? image;

  @override
  CardHomeController get controller => super.controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(
          controller.blendColor.value,
          BlendMode.color,
        ),
        child: PhotoView(
          enableRotation: controller.isImageEditable.value,
          disableGestures: !controller.isImageEditable.value,
          imageProvider: FileImage(
            File("$image"),
          ),
        ),
      );
    });
  }
}
