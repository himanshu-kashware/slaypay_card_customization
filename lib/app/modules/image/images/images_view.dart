import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      return InteractiveViewer(
        scaleEnabled: controller.isImageEditable.value,
        panEnabled: controller.isImageEditable.value,
        minScale: 0.05,
        maxScale: 1.0,
        constrained: false,
        child: Transform.rotate(
          angle: controller.imageAngle.value * pi / 180,
          child: Image.file(
            File(
              "$image",
            ),
            fit: BoxFit.cover,
            color: controller.blendColor.value,
            colorBlendMode: BlendMode.color,
          ),
        ),
      );
    });
  }
}
