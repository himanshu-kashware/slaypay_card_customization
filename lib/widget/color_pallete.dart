import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/util/color_detail.dart';

class ColorPallete extends StatefulWidget {
  Function(ColorDetail) selectedSolidColor;
  ColorDetail selectedColor;
  VoidCallback onCloseTap;

  ColorPallete(
      {required this.selectedSolidColor,
      required this.onCloseTap,
      required this.selectedColor});

  @override
  _ColorPalleteState createState() => _ColorPalleteState();
}

class _ColorPalleteState extends State<ColorPallete> {
  List<ColorDetail> colorsList = customColorList;
  int _currentFocusedIndex = 0;
  final AutoScrollController controller = AutoScrollController();

  @override
  void initState() {
    super.initState();
  }

  setDefaultColor() {
    for (int i = 0; i < colorsList.length; i++) {
      if (widget.selectedColor == colorsList[i]) {}
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width / 4,
      child: Row(
        children: [
          IconButton(
            splashColor: AppColors.accentColor,
            highlightColor: AppColors.accentColor,
            onPressed: () {

              _currentFocusedIndex--;
              if (_currentFocusedIndex < 0) {
                _currentFocusedIndex = colorsList.length - 1;
              }

              controller.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);

              setState(() {});

            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: colorsList.length,
              shrinkWrap: true,
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AutoScrollTag(
                  controller: controller,
                  key: ValueKey(index),
                  index: index,
                  child: AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 50),
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
                                  for (int i = 0; i < colorsList.length; i++) {
                                    if (colorsList[i] == colorsList[index]) {
                                      colorsList[i].isSelected = true;
                                    } else {
                                      colorsList[i].isSelected = false;
                                    }
                                  }
                                  widget.selectedSolidColor(colorsList[index]);
                                  setState(() {});
                                },
                                child: AnimatedContainer(
                                  height: colorsList[index].isSelected
                                      ? Get.width / 10
                                      : Get.width / 15,
                                  width: colorsList[index].isSelected
                                      ? Get.width / 10
                                      : Get.width / 15,
                                  decoration: BoxDecoration(
                                      color: colorsList[index].color,
                                      shape: BoxShape.circle,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 2.0,
                                        ),
                                      ]),
                                  child: colorsList[index].isSelected
                                      ? const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(Icons.check,color: Colors.white,)
                                        )
                                      : const SizedBox(),
                                  duration: const Duration(milliseconds: 250),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            splashColor: AppColors.accentColor,
            onPressed: () {

              _currentFocusedIndex++;
              if (_currentFocusedIndex > colorsList.length) {
                _currentFocusedIndex = 0;
              }
              controller.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);
              setState(() {});

            },
            icon: const Icon(Icons.arrow_forward_ios_sharp),
          ),
        ],
      ),
    );
  }
}
