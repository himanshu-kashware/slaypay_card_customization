import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/widget/google_fonts_list.dart';

Widget fontFamilyTab(
    {required List<SlayPayGoogleFonts> fontsList,
    required Function(SlayPayGoogleFonts) selectedFont,
    required Function(List<SlayPayGoogleFonts>) updatedList}) {
  return AnimationLimiter(
    child: SizedBox(
      height: Get.width / 5,
      width: Get.width,
      child: ListView.builder(
        itemCount: fontsList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 40,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          selectedFont(fontsList[index]);
                          final List<SlayPayGoogleFonts> _fonts = [];
                          for (int i = 0; i < fontsList.length; i++) {
                            if (index == i) {
                              fontsList[i].isSelected = true;
                            } else {
                              fontsList[i].isSelected = false;
                            }
                            _fonts.add(fontsList[i]);
                          }

                          fontsList.clear();
                          fontsList.addAll(_fonts);
                          updatedList(fontsList);
                        },
                        child: AnimatedContainer(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: fontsList[index].isSelected
                                  ? AppColors.accentColor
                                  : Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                ),
                              ]),
                          duration: const Duration(milliseconds: 250),
                          child: Center(
                            child: Text(
                              fontsList[index].name,
                              style: fontsList[index].font,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
