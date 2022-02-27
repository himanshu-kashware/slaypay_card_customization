import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/util/color_detail.dart';
import 'package:slaypay_cc/util/pattern_detail.dart';
import 'package:slaypay_cc/widget/color_pallete.dart';
import 'package:slaypay_cc/widget/custom_bottom_sheet_options.dart';
import 'package:slaypay_cc/widget/pattern_pallete.dart';

class CardHomeController extends GetxController {
  final cardStack = RxList<Widget>().obs;

  //=====================Card Color ==================================================
  final Rx<ColorDetail> cardSelectedColor =
      ColorDetail.name(true, Colors.green).obs;

  //=====================Card Pattern ==================================================
  final Rx<PatternDetail> cardSelectedPattern = PatternDetail(null, true).obs;

  @override
  void onInit() {
    addDefaultWidget();
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



  //=== Add Pattern==================================================

  void addPattern(){
    Widget _pattern =  SvgPicture.asset(
      cardSelectedPattern.value.pattern_data!,
     fit: BoxFit.fill,
      );



    if(cardStack.value.length>2){
      cardStack.value.removeAt(0);
      cardStack.value.insert(0, _pattern);
    }else{
      cardStack.value.insert(0, _pattern);
    }

  }



  //==================================================================================
  void openColorPallete() {
    CustomBottomSheet(
      customChild: Stack(
        alignment: Alignment.topCenter,
        children: [
          ColorPallete(
              onCloseTap: () {
                Get.back();
              },
              selectedColor: cardSelectedColor.value,
              selectedSolidColor: (ColorDetail colorDetail) {
                cardSelectedColor.value = colorDetail;
              }),
          ClipOval(
            child: Material(
              color: AppColors.accentColor, // Button color
              child: InkWell(
                splashColor: AppColors.accentColor, // Splash color
                onTap: () {
                  Get.back();
                },
                child: const SizedBox(
                    width: 25, height: 25, child: Icon(Icons.clear)),
              ),
            ),
          ),
        ],
      ),
    );
  }


  //================================================================================
  void openPatternPallete() {
    CustomBottomSheet(
      customChild: Stack(
        alignment: Alignment.topCenter,
        children: [
          PatternPallete(
              preFilledPattern: cardSelectedPattern.value,
              selectedPattern: (PatternDetail patternDetail) {
                cardSelectedPattern.value = patternDetail;
                addPattern();
              }),
          ClipOval(
            child: Material(
              color: AppColors.accentColor, // Button color
              child: InkWell(
                splashColor: AppColors.accentColor, // Splash color
                onTap: () {
                  Get.back();
                },
                child: const SizedBox(
                    width: 25, height: 25, child: Icon(Icons.clear)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
