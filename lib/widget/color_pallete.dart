import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();

  }
  setDefaultColor(){
    for (int i = 0; i < colorsList.length; i++) {
     if(widget.selectedColor==colorsList[i]){

     }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width / 4,
      width: Get.width,
      child: ListView.builder(
        itemCount: colorsList.length,
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
                              ? Get.width / 15
                              : Get.width / 20,
                          width: colorsList[index].isSelected
                              ? Get.width / 15
                              : Get.width / 20,
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
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 10,
                                    child: SizedBox()),
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
          );
        },
      ),
    );
  }
}
