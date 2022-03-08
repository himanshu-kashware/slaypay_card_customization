import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/app/modules/image/filters.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/widget/show_animated_bottom_sheet.dart';
import 'package:slaypay_cc/widget/customDialog.dart';
import 'package:slaypay_cc/widget/main_menu_options.dart';

import '../../../../widget/text_sizer.dart';
import '../controllers/card_home_controller.dart';

class CardHomeView extends GetView<CardHomeController> {
  @override
  CardHomeController get controller => super.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 66,
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              Assets.imagesLogo,
              color: AppColors.black,
              height: 33,
              width: 40,
            ),
            Obx(() {
              return Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.undo();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.undo,
                          color: controller.undoList.value.isNotEmpty
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        controller.redo();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.redo,
                          color: controller.redoList.value.isNotEmpty
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                        ),
                      ))
                ],
              );
            })
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
        return SafeArea(
          bottom: false,
          child: Stack(
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
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color(0xff6F7FAF),
                  onPressed: () {
                    showCustomDialog(onTap: () {
                      controller.cardStack.value.clear();
                      controller.addDefaultWidget();
                      Get.back();
                    });
                  },
                  child: SvgPicture.asset(Assets.imagesRemove),
                ),
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
                                    iconData: Icons.color_lens_rounded,
                                    title: 'Bg Color',
                                  ),
                                  MainMenuOptions(
                                    onTap: () {
                                      controller.openPatternPallete(
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
                                  MainMenuOptions(
                                    onTap: () {
                                      controller.addTextWidget();
                                    },
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
                  : const SizedBox()
            ],
          ),
        );
      }),
    );
  }
}
