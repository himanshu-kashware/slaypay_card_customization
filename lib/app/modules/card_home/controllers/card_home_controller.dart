import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/util/color_detail.dart';
import 'package:slaypay_cc/widget/color_pallete.dart';
import 'package:slaypay_cc/widget/custom_bottom_sheet_options.dart';

class CardHomeController extends GetxController {
  final cardStack = RxList<Widget>().obs;
  final cardColorList = RxList<ColorDetail>().obs;

  final Rx selectedColor = Colors.white.obs;

  @override
  void onInit() {
    addDefaultWidget();
    cardColorList.value.addAll(getColorsList());
    super.onInit();
  }

  @override
  void onClose() {}

  addDefaultWidget() {
    Widget _chipView = Positioned(
      top: 70,
      left: 45,
      child: SvgPicture.asset(
        Assets.imagesChip,
        height: 35,
        width: 35,
      ),
    );
    Widget _visaView = Positioned(
      bottom: 20,
      right: 25,
      child: SvgPicture.asset(
        Assets.imagesVisa,
        height: 20,
        width: 30,
      ),
    );
    cardStack.value.add(_chipView);
    cardStack.value.add(_visaView);
  }

  void openColorPallete() {
    CustomBottomSheet(
        customChild: ColorPallete(
            updatedList: (List<ColorDetail> colorList) {
              cardColorList.value.addAll(colorList);
            },
            onCloseTap: () {
              Get.back();
            },
            colorsList: cardColorList.value,
            selectedSolidColor: (ColorDetail colorDetail) {
              selectedColor.value = colorDetail.color;
            }));
  }
}
