import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/widget/flutter_text_widget/resizable_widget.dart';
import 'package:slaypay_cc/widget/flutter_text_widget/resizable_widget_controller.dart';

const double dragWidgetSize = 20;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final areaHeight = Get.height * 0.70;
    final areaWidth = Get.width * 0.70;
    final controller = Get.put(
      ResizableWidgetController(
        initialPosition: Offset(areaWidth / 2, areaHeight / 2),
        areaHeight: areaHeight,
        areaWidth: areaWidth,
        height: areaHeight / 4,
        width: areaWidth / 4,
        minWidth: 50,
        minHeight: 50,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          color: Colors.black,
          child: UnconstrainedBox(
            child: Container(
              width: areaWidth,
              height: areaHeight,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bin.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ResizableWidget(
                dragWidgetHeight: dragWidgetSize,
                dragWidgetWidth: dragWidgetSize,
                controller: controller,
                dragWidget: Container(
                  height: dragWidgetSize,
                  width: dragWidgetSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: AutoSizeTextField(
                    autofocus: true,
                    maxLines: null,
                    minFontSize: 40,
                    expands: true,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: TextEditingController(),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
