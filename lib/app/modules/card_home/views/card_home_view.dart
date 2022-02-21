import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/widget/color_pallete.dart';
import 'package:slaypay_cc/widget/custom_bottom_sheet_options.dart';
import 'package:slaypay_cc/widget/show_animated_bottom_sheet.dart';
import 'package:slaypay_cc/widget/customDialog.dart';
import 'package:slaypay_cc/widget/main_menu_options.dart';

import '../controllers/card_home_controller.dart';

class CardHomeView extends GetView<CardHomeController> {
  @override
  // TODO: implement controller
  CardHomeController get controller => super.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 66,
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.imagesLogo,
              color: AppColors.black,
              height: 33,
              width: 40,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                        minimumSize: const Size(120, 70)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                Assets.imagesBackground,
                repeat: ImageRepeat.repeat,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height / 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 8,
                          lightSource: LightSource.topLeft,
                          color: const Color(0xffFFD6D8)),
                      child: AspectRatio(
                        aspectRatio: 1.586,
                        child: SizedBox(
                          child: Stack(
                            children: controller.cardStack.value,
                          ),
                        ),
                      )),
                )
              ],
            ),
            Positioned(
              right: 10,
              top: 24,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: const Color(0xff6F7FAF),
                onPressed: () {
                  showCustomDialog();
                },
                child: SvgPicture.asset(Assets.imagesRemove),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: showAnimatedBottomSheet(
                childWidget: IntrinsicWidth(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MainMenuOptions(
                            onTap: () {
                              controller.openColorPallete();
                            },
                            iconData: Icons.color_lens_rounded,
                            title: 'Bg Color',
                          ),
                          MainMenuOptions(
                            onTap: () {},
                            iconData: Icons.pattern,
                            title: 'Patterns',
                          ),
                          MainMenuOptions(
                            onTap: () {},
                            iconData: Icons.image,
                            title: 'Image',
                          ),
                          MainMenuOptions(
                            onTap: () {},
                            iconData: Icons.font_download_outlined,
                            title: 'Add Text',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
