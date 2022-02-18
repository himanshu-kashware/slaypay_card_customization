import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';

import '../controllers/card_home_controller.dart';

class CardHomeView extends GetView<CardHomeController> {
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
      body: Stack(
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
                        boxShape:
                            NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: const Color(0xffF29791)),
                    child: AspectRatio(
                      aspectRatio: 1.586,
                      child: SizedBox(
                        child: Stack(
                          children: [

                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),

          Positioned(
            right:10,
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
        ],
      ),
    );
  }
}
