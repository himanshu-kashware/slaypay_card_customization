import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:slaypay_cc/generated/assets.dart';
import 'package:slaypay_cc/util/pattern_detail.dart';

import '../constants/app_colors.dart';

class PatternPallete extends StatefulWidget {
  Function(PatternDetail) selectedPattern;
  PatternDetail preFilledPattern;

  PatternPallete(
      {Key? key, required this.selectedPattern, required this.preFilledPattern}) : super(key: key);

  @override
  _PatternPalleteState createState() => _PatternPalleteState();
}

class _PatternPalleteState extends State<PatternPallete> {
  final List<PatternDetail> _patternList = customPatternList;
  int _currentFocusedIndex = 0;
  final AutoScrollController controller = AutoScrollController();
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
                _currentFocusedIndex = _patternList.length - 1;
              }

              controller.scrollToIndex(_currentFocusedIndex,
                  preferPosition: AutoScrollPosition.begin);

              setState(() {});

            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _patternList.length,
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
                                  for (int i = 0; i < _patternList.length; i++) {
                                    if (_patternList[i] == _patternList[index]) {
                                      _patternList[i].isSelected = true;
                                    } else {
                                      _patternList[i].isSelected = false;
                                    }
                                  }
                                  widget.selectedPattern(_patternList[index]);
                                  setState(() {});
                                },
                                child: AnimatedContainer(
                                  height: Get.width / 10,
                                  width: Get.width / 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: _patternList[index].pattern_data == null
                                      ? const SizedBox()
                                      : SvgPicture.asset(
                                          _patternList[index].pattern_data!,
                                          fit: BoxFit.fill,
                                          color: Colors.grey,
                                        ),
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
              if (_currentFocusedIndex > _patternList.length) {
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
