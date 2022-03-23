import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:slaypay_cc/app/modules/card_home/controllers/card_home_controller.dart';

class ImagesComponent extends GetView<CardHomeController> {
  ImagesComponent({Key? key, this.image}) : super(key: key);

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
          loadingBuilder: (c, a) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          },
          onScaleEnd: (
            context,
            details,
            controllerValue,
          ) {
            controller.imagePosX.value = controllerValue.position.dx;
            controller.imagePosY.value = controllerValue.position.dy;
            controller.imageAngle.value = controllerValue.rotation;

            controller.undoList.value.add(controller.cardData.copyWith(
                imageData: controller.cardData.imageData?.copyWith(
              imageAngle: controllerValue.rotation,
              imagePosX: controllerValue.position.dx,
              imageScale: controllerValue.scale,
              imagePosY: controllerValue.position.dy,
            )));
          },
          enableRotation: controller.isImageEditable.value,
          disableGestures: !controller.isImageEditable.value,
          controller: controller.controllerBase.value,
          imageProvider: FileImage(
            File("$image"),
          ),
        ),
      );
    });
  }
}
