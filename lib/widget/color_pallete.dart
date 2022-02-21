import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/util/color_detail.dart';

class ColorPallete  extends StatefulWidget {
  List<ColorDetail> colorsList;
  Function(ColorDetail) selectedSolidColor;
      Function(List<ColorDetail>)  updatedList;
  VoidCallback onCloseTap;

ColorPallete( {required this.colorsList,
  required this.selectedSolidColor,
  required this.onCloseTap,
  required this.updatedList});
  @override
  _ColorPalleteState createState() => _ColorPalleteState();
}

class _ColorPalleteState extends State<ColorPallete> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 4,
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      height: Get.width / 15,
                      width: Get.width / 15,
                      decoration: const BoxDecoration(
                          color: Color(0xffD9D9D9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffD9D9D9),
                              blurRadius: 2.0,
                            ),
                          ]),
                      duration: const Duration(milliseconds: 250),
                    ),
                    SizedBox(
                      height: Get.width / 70,
                    ),
                    const Text(
                      'Solid',
                      style:TextStyle(
                          fontSize: 10, color: Color(0xff656565)),
                    )
                  ],
                ),
                VerticalDivider(
                  indent: Get.width / 20,
                  endIndent: Get.width / 20,
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: widget.colorsList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
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
                                widget.selectedSolidColor(widget.colorsList[index]);
                                final List<ColorDetail> _colors = [];
                                for (int i = 0; i < widget.colorsList.length; i++) {
                                  if (index == i) {

                                    widget.colorsList[i].isSelected = true;

                                  } else {
                                    widget.colorsList[i].isSelected = false;
                                  }
                                  _colors.add(widget.colorsList[i]);
                                  widget.updatedList( widget.colorsList);
                                }
                                widget.colorsList.clear();
                                widget.colorsList.addAll(_colors);

                              },
                              child: AnimatedContainer(
                                height: widget.colorsList[index].isSelected
                                    ? Get.width / 15
                                    : Get.width / 20,
                                width: widget.colorsList[index].isSelected
                                    ? Get.width / 15
                                    : Get.width / 20,
                                decoration: BoxDecoration(
                                    color: widget.colorsList[index].color,
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                      ),
                                    ]),
                                duration: const Duration(milliseconds: 250),
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
        ],
      ),
    );
  }
}

