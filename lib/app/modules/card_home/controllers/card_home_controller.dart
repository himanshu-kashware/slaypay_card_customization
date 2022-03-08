import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:slaypay_cc/app/model/card_data.dart';
import 'package:slaypay_cc/app/model/pattern.dart';
import 'package:slaypay_cc/app/modules/image/filters.dart';

import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/util/color_detail.dart';
import 'package:slaypay_cc/util/pattern_detail.dart';
import 'package:slaypay_cc/widget/CustomSlider.dart';
import 'package:slaypay_cc/widget/color_pallete.dart';
import 'package:slaypay_cc/widget/custom_bottom_sheet_options.dart';
import 'package:slaypay_cc/widget/flutter_text_widget/test.dart';
import 'package:slaypay_cc/widget/pattern_pallete.dart';
import 'package:slaypay_cc/widget/text_editor/text_editor.dart';
import 'package:slaypay_cc/widget/text_properties.dart';

import '../../image/images/images_view.dart';

class CardHomeController extends GetxController {
  final cardStack = RxList<Widget>().obs;

  //=====================Card Color ==================================================
  final Rx<ColorDetail> cardSelectedColor =
      ColorDetail.name(true, AppColors.accentColor).obs;

  //=====================Card Pattern ==================================================
  final Rx<PatternDetail> cardSelectedPattern = PatternDetail(null, true).obs;
  final patternOpacity = 1.0.obs;
  final patternSize = 0.5.obs;
  PatternData? patternData;

  //======================Image Editable ==========================================

  final isImageEditable = false.obs;
  var imageAngle = 0.0.obs;
  var blendColor = Colors.transparent.obs;
  final showFilter = false.obs;
  final selectedImage = ''.obs;

//=====================================Text Fields ======================================

  final textLists = RxList<List<TextProperties>>().obs;

  //===============================Card Data ============================================

  CardData cardData =
      CardData(patternData: null, cardBg: AppColors.accentColor, image: null);

  //=======================Undo Data ================================================

  final undoList = RxList<CardData>().obs;

  //===========================Redo Data =============================================

  final redoList = RxList<CardData>().obs;

  @override
  void onInit() {
    addDefaultWidget();
    super.onInit();
  }

  final fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];
  RxString _text = ''.obs;
  TextStyle _textStyle = const TextStyle(
    // fontSize: 25,
    color: Colors.black,
    fontFamily: 'Billabong',
  );
  TextAlign _textAlign = TextAlign.center;
  addTextWidget() async {
    cardStack.value.add(
      Center(
        child: TextEditor(
          fonts: fonts,
          text: _text.value,
          textStyle: _textStyle,
          textAlingment: _textAlign,
          minFontSize: 12,
          onEditCompleted: (style, align, text) {
            _text.value = text;
            _textStyle = style;
            _textAlign = align;

            isDone(true);
            // hideBottomSheet(false);
          },
        ),
      ),
    );
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

  void addPattern() {
    Widget _pattern = Transform.scale(
      scale: patternSize.value,
      child: SvgPicture.asset(
        cardSelectedPattern.value.pattern_data!,
        fit: BoxFit.fill,
        color: Colors.grey.withOpacity(patternOpacity.value),
      ),
    );

    if (cardStack.value.length > 2) {
      cardStack.value.removeAt(0);
      cardStack.value.insert(0, _pattern);
    } else {
      cardStack.value.insert(0, _pattern);
    }
  }

  //=================================Add Image ========================

  void addImage({required String image}) {
    Widget _pattern = ImagesComponent(image: image);
    if (cardStack.value.length > 2) {
      cardStack.value.removeAt(0);
      cardStack.value.insert(0, _pattern);
    } else {
      cardStack.value.insert(0, _pattern);
    }
    isImageEditable(true);
    Get.back();
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

                cardData = cardData.copyWith(cardBg: colorDetail.color);
                undoList.value.add(cardData);
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
  void openPatternPallete(
      {required double opacityValue,
      required double sizeValue,
      required Function(double) onSizeChange,
      required Function(double) onOpacityChange}) {
    final opacity = 0.0.obs;
    final size = 0.0.obs;

    opacity.value = opacityValue;
    size.value = sizeValue;
    CustomBottomSheet(
      customChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Obx(() {
            return Row(
              children: [
                CustomSlider(
                  title: "OPACITY",
                  value: opacity.value,
                  max: 1,
                  onChanged: (value) {
                    onOpacityChange(value);
                    opacity.value = value;
                    addPattern();
                  },
                ),
                CustomSlider(
                  title: "SIZE",
                  max: 2,
                  value: size.value,
                  onChanged: (value) {
                    onSizeChange(value);
                    size.value = value;
                    addPattern();
                  },
                ),
              ],
            );
          }),
          PatternPallete(
              preFilledPattern: cardSelectedPattern.value,
              selectedPattern: (PatternDetail patternDetail) {
                cardSelectedPattern.value = patternDetail;
                addPattern();
              }),
        ],
      ),
    );
  }

  //========================================Open Image Pallete =====================================

  void openImagePallete() {
    CustomBottomSheet(
      customChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Choose your image :"),
                ),
                GestureDetector(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();

                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      imageAngle.value = 0;
                      blendColor.value = AppColors.accentColor;
                      addImage(image: image.path);
                    }

                    selectedImage.value = image!.path;
                    // homeController.isSheetOpen.value = false;
                    // Get.back();
                    // homeController.bottomNavVisible.value = false;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                            color: const Color(0xff000000).withOpacity(0.19),
                          ),
                        ],
                        color: AppColors.accentColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: SvgPicture.asset(Assets.imagesUploadImage),
                          ),
                          const SizedBox(height: 8),
                          const FittedBox(
                            child: Text(
                              "Upload Picture",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//==============================Open Filter Dialog ========================================
  void openFilterDialog() {
    CustomBottomSheet(
      customChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          SizedBox(
              height: 70,
              child: MakeFilter(
                image: selectedImage.value,
                onFilterSelected: (color) {
                  blendColor.value = color;
                },
              ))
        ],
      ),
    );
  }

  void undo() {
    if (undoList.value.isNotEmpty) {
      final cardValue = undoList.value.last;

      cardSelectedColor.value = ColorDetail.name(true, cardValue.cardBg!);

      undoList.value.removeLast();
    }
  }

  void redo() {
    if (undoList.value.isNotEmpty) {
      redoList.value.add(undoList.value.last);
    }
  }
}
