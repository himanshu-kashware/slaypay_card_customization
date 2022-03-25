import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/widget/show_animated_bottom_sheet.dart';
import 'package:slaypay_cc/widget/customDialog.dart';
import 'package:slaypay_cc/widget/main_menu_options.dart';
import '../controllers/card_home_controller.dart';

class CardHomeView extends GetView<CardHomeController> {
  CardHomeView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(CardHomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 66,
          backgroundColor: AppColors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                Assets.cardImagesLogo,
                color: AppColors.black,
                height: 33,
                width: 35,
              ),
            ],
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                  Assets.cardImagesBackground,
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
                            color: controller.cardSelectedColor.value.color),
                        child: AspectRatio(
                          aspectRatio: 1.586,
                          child: SizedBox(
                            child: Stack(
                              children: controller.cardStack.value,
                            ),
                          ),
                        )),
                  ),
                  controller.isImageEditable.value
                      ? SizedBox(
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.cardStack.value.removeAt(0);
                                      controller.isImageEditable.value = false;
                                    },
                                    child: const CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 40,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.isImageEditable.value = false;
                                      controller.openFilterDialog();
                                    },
                                    child: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        child: Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                          size: 40,
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              Positioned(
                right: 10,
                top: 24,
                child: Obx(() {
                  return SizedBox(
                    width: Get.width / 2.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              controller.undo();
                            },
                            child: CircleAvatar(
                              backgroundColor: const Color(0xff6F7FAF),
                              child: Icon(
                                Icons.undo,
                                color: controller.undoList.value.isEmpty ||
                                        controller.undoList.value.length == 1
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            controller.redo();
                          },
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff6F7FAF),
                            child: Icon(
                              Icons.redo,
                              color: controller.redoList.value.isNotEmpty
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              showCustomDialog(onTap: () {
                                controller.cardStack.value.clear();
                                controller.addDefaultWidget();
                                Get.back();
                              });
                            },
                            child: CircleAvatar(
                                backgroundColor: const Color(0xff6F7FAF),
                                child:
                                    SvgPicture.asset(Assets.cardImagesRemove))),
                        const SizedBox()
                      ],
                    ),
                  );
                }),
              ),
              !controller.isImageEditable.value
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: showAnimatedBottomSheet(
                        childWidget: IntrinsicWidth(
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MainMenuOptions(
                                    onTap: () {
                                      controller.openColorPallete();
                                    },
                                    iconData: Icons.format_color_fill,
                                    title: 'Card Colour',
                                  ),
                                  MainMenuOptions(
                                    onTap: () {
                                      controller.openPatternPallete(
                                          onPatternSelected: (pattern) {},
                                          opacityValue:
                                              controller.patternOpacity.value,
                                          sizeValue:
                                              controller.patternSize.value,
                                          onOpacityChange: (double value) {
                                            controller.patternOpacity.value =
                                                value;
                                          },
                                          onSizeChange: (double value) {
                                            controller.patternSize.value =
                                                value;
                                          });
                                    },
                                    iconData: Icons.pattern,
                                    title: 'Patterns',
                                  ),
                                  MainMenuOptions(
                                    onTap: () {
                                      controller.openImagePallete();
                                    },
                                    iconData: Icons.image,
                                    title: 'Image',
                                  ),
                                  // MainMenuOptions(
                                  //   onTap: () {
                                  //     controller.textList.value.add(
                                  //       TextData(
                                  //           textString: "text",
                                  //           textColor: Colors.black,
                                  //           textPositionX: 0,
                                  //           textPositionY: 0,
                                  //           textRotationAngle: 0),
                                  //     );
                                  //
                                  //     controller.cardStack.value
                                  //         .add(MovableText(
                                  //       xPosition: 0,
                                  //       color: Colors.brown,
                                  //       yPosition: 0,
                                  //     ));
                                  //
                                  //     controller.openTextDialog(
                                  //         addedText:
                                  //             controller.textList.value.last);
                                  //   },
                                  //   iconData: Icons.font_download_outlined,
                                  //   title: 'Add Text',
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        }),
      ),
    );
  }
}
