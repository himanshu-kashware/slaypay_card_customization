import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/app/model/text_data.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/widget/color_pallete.dart';
import '../widget/font_family_tab.dart';
import '../widget/google_fonts_list.dart';
import 'color_detail.dart';

class FontPallete extends StatelessWidget {
  final TextData addedText;

  FontPallete(this.addedText, {Key? key}) : super(key: key);

  final isFontStyleSelected = false.obs;
  final isFontColorSelected = false.obs;
  final isFontSizeSelected = false.obs;

  final selectedOption = Status.textFontStyle.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width / 3,
      width: Get.width,
      child: Obx(
        () => Column(
          children: [
            selectedOption.value == Status.textFontStyle
                ? Expanded(
                    child: fontFamilyTab(
                        selectedFont: (SlayPayGoogleFonts) {},
                        fontsList: getFontsList(),
                        updatedList: (List<SlayPayGoogleFonts> updatedList) {}),
                  )
                : selectedOption.value == Status.textColor
                    ? Expanded(
                        child: ColorPallete(
                        onCloseTap: () {},
                        selectedColor:
                            ColorDetail.name(true, AppColors.accentColor),
                        selectedSolidColor: (ColorDetail) {},
                      ))
                    : const SizedBox(),
            Expanded(
              child: AnimationLimiter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                        build_bottom_icon(
                            title: "Text Font",
                            enableColor:
                                selectedOption.value == Status.textFontStyle
                                    ? AppColors.accentColor
                                    : null,
                            assetName: "assets/images/text_style.svg",
                            onClick: () {
                              selectedOption.value = Status.textFontStyle;
                            }),
                        build_bottom_icon(
                            title: "Text Color",
                            enableColor:
                                selectedOption.value == Status.textColor
                                    ? AppColors.accentColor
                                    : null,
                            assetName: "assets/images/text_color.svg",
                            onClick: () {
                              selectedOption.value = Status.textColor;
                            }),
                        build_bottom_icon(
                            title: "Emoji",
                            enableColor: selectedOption.value == Status.emoji
                                ? AppColors.accentColor
                                : null,
                            assetName: "assets/images/emoji.svg",
                            onClick: () {
                              selectedOption.value = Status.emoji;
                            }),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget build_bottom_icon(
    {required String assetName,
    required String? title,
    required Color? enableColor,
    required VoidCallback onClick}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: SvgPicture.asset(
            assetName,
            fit: BoxFit.contain,
            color: enableColor,
          ),
        ),
        title != null
            ? Expanded(
                child: SizedBox(
                  child: Text(
                    title,
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xff656565)),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}

enum Status { textFontStyle, textColor, emoji }
