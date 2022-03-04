import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/text_editor/text_editor.dart';
import '../app/modules/text_editor/text_editor_data.dart';


RxDouble angle = 0.1.obs;
RxDouble fontSize = 12.0.obs;
RxBool showBlank = true.obs;

class ResizebleTextWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final bool? isText;
  final bool? isDone;
  const ResizebleTextWidget(
      {required this.child,
        this.height,
        this.width,
        this.isText,
        required this.isDone});

  final Widget child;
  @override
  _ResizebleTextWidgetState createState() => _ResizebleTextWidgetState();
}

const ballDiameter = 5.0;

class _ResizebleTextWidgetState extends State<ResizebleTextWidget> {
  late double height;
  late double width;
  bool isCorner = false;

  double rightHeight = 0.0;
  double rightWidth = 0.0;

  double top = Get.width > 600 ? Get.width * 0.10 : Get.width * 0.25;
  double left = Get.width > 600 ? Get.width * 0.15 : Get.width * 0.35;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    height = widget.height ?? 100;
    width = widget.width ?? 100;
  }

  // final TextController _textController = Get.put(TextController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: AspectRatio(
        aspectRatio: 1.58,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: top,
              left: left,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: widget.isText == false
                      ? Colors.blueGrey
                      : Colors.transparent,
                  border: widget.isDone == false
                      ? Border.all(
                    width: 2,
                    color: Colors.white70,
                  )
                      : Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                // need tp check if draggable is done from corner or sides
                child: isCorner
                    ? FittedBox(
                  child: widget.child,
                )
                    : Center(
                  child: widget.child,
                ),
              ),
            ),
            // top left
            Positioned(
              // top: top - ballDiameter / 2,
              top: top - ballDiameter / 0.60,
              // left: left - ballDiameter / 2,
              left: left - ballDiameter / 0.20,
              child: ManipulatingBall(
                active: false,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var mid = (dx + dy) / 2;
                  var newHeight = height - 2 * mid;
                  var newWidth = width - 2 * mid;

                  setState(() {
                    // isCorner = true;
                    // height = newHeight > 0 ? newHeight : 0;
                    // width = newWidth > 0 ? newWidth : 0;
                    // top = top + mid;
                    // left = left + mid;
                    // height = newHeight > 0 ? newHeight : 0;
                  });
                  showBlank(true);
                },
                handlerWidget: HandlerWidget.CUT,
              ),
            ),
            // top middle
            Positioned(
              top: top - ballDiameter / 2,
              left: left + width / 2 - ballDiameter / 2,
              child: ManipulatingBall(
                active: false,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var newHeight = height - dy;

                  setState(() {
                    isCorner = false;

                    height = newHeight > 0 ? newHeight : 0;
                    final model = TextEditorData.of(context).textStyleModel;
                    // model.editFontSize(height / 5);
                    // fontSize.value >= 11.9 && fontSize.value <= 36.1
                    //     ? fontSize.value = fontSize.value - dy
                    //     : () {
                    //         fontSize.value = 12.0;
                    //       };
                    if (fontSize.value < 12.0) {
                      fontSize.value = 12.0;
                    } else if (fontSize.value > 36.0) {
                      fontSize.value = 36.0;
                    } else {
                      fontSize.value = fontSize.value - dy;
                    }
                    model.editFontSize(fontSize.value);
                    top = top + dy;
                  });
                },
                handlerWidget: HandlerWidget.HORIZONTAL,
              ),
            ),
            // top right
            Positioned(
              top: top - ballDiameter / 0.60,
              left: left + width - ballDiameter / 0.2,
              // left:
              //     rightWidth == 0 ? left + ballDiameter * 24 : rightWidth / 0.2,
              child: ManipulatingBall(
                active: true,
                isDone: widget.isDone!,
                handlerWidget: HandlerWidget.DONE,
              ),
            ),
            // center right
            Positioned(
              top: top + height / 2 - ballDiameter / 2,
              left: left + width - ballDiameter / 2,
              child: ManipulatingBall(
                active: true,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var newWidth = width + dx;

                  setState(() {
                    isCorner = false;
                    final model = TextEditorData.of(context).textStyleModel;

                    width = newWidth > 0 ? newWidth : 0;
                    if (fontSize.value < 12.0) {
                      fontSize.value = 12.0;
                    } else if (fontSize.value > 36.0) {
                      fontSize.value = 36.0;
                    } else {
                      fontSize.value = fontSize.value + dx;
                    }
                    model.editFontSize(fontSize.value);
                    // model.editFontSize(width / 5);
                  });
                },
                handlerWidget: HandlerWidget.VERTICAL,
              ),
            ),
            // bottom right
            Positioned(
              // top: top + height - ballDiameter / 2,
              top: top + height - ballDiameter / 0.60,
              // left: left + width - ballDiameter / 2,
              left: left + width - ballDiameter / 0.20,
              child: ManipulatingBall(
                active: true,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var mid = (dx + dy) / 2;

                  var newHeight = height + 2 * mid;
                  // var newWidth = width + 2 * mid;
                  var newWidth = width + dx;

                  setState(() {
                    rightWidth = newWidth;
                    // isCorner = true;

                    // height = newHeight > 0 ? newHeight : 0;
                    // width = newWidth > 0 ? newWidth : 0;
                    // top = top - mid;
                    // left = left - mid;
                    // height = newHeight > 0 ? newHeight : 0;
                    angle.value = angle.value + (dy / 30000);
                    width = newWidth > 0 ? newWidth : 0;
                    final model = TextEditorData.of(context).textStyleModel;
                    if (fontSize.value < 12.0) {
                      fontSize.value = 12.0;
                    } else if (fontSize.value > 36.0) {
                      fontSize.value = 36.0;
                    } else {
                      fontSize.value = fontSize.value + dx;
                    }
                    model.editFontSize(fontSize.value);
                  });
                  // angle.value += 0.1;
                },
                handlerWidget: HandlerWidget.ROTATORY,
              ),
            ),
            // bottom center
            Positioned(
              top: top + height - ballDiameter / 2,
              left: left + width / 2 - ballDiameter / 2,
              child: ManipulatingBall(
                active: false,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var newHeight = height + dy;

                  setState(() {
                    isCorner = false;

                    height = newHeight > 0 ? newHeight : 0;
                    final model = TextEditorData.of(context).textStyleModel;
                    model.editFontSize(height / 5);
                  });
                },
                handlerWidget: HandlerWidget.HORIZONTAL,
              ),
            ),
            // bottom left
            Positioned(
              top: top + height - ballDiameter / 2,
              left: left - ballDiameter / 2,
              child: ManipulatingBall(
                active: false,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var mid = ((dx * -1) + dy) / 2;

                  var newHeight = height + 2 * mid;
                  var newWidth = width + 2 * mid;

                  setState(
                        () {
                      // isCorner = true;

                      // height = newHeight > 0 ? newHeight : 0;
                      // width = newWidth > 0 ? newWidth : 0;
                      // top = top - mid;
                      // left = left - mid;
                      // height = newHeight > 0 ? newHeight : 0;
                      // angle.value = angle.value + (dy / 10000);
                      // angle.value = angle.value - 0.0001;
                    },
                  );
                },
                handlerWidget: HandlerWidget.VERTICAL,
              ),
            ),
            //left center
            Positioned(
              top: top + height / 2 - ballDiameter / 2,
              left: left - ballDiameter / 2,
              child: ManipulatingBall(
                active: false,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  var newWidth = width - dx;

                  setState(() {
                    isCorner = false;

                    width = newWidth > 0 ? newWidth : 0;
                    left = left + dx;
                    final model = TextEditorData.of(context).textStyleModel;
                    model.editFontSize(width / 5);
                  });
                },
                handlerWidget: HandlerWidget.HORIZONTAL,
              ),
            ),
            // center center
            Positioned(
              top: top + height / 2 - ballDiameter / 2,
              left: left + width / 2 - ballDiameter / 2,
              child: ManipulatingBall(
                active: true,
                isDone: widget.isDone!,
                onDrag: (dx, dy) {
                  setState(() {
                    isCorner = false;

                    top = top + dy;
                    left = left + dx;
                  });
                },
                handlerWidget: HandlerWidget.CENTRAL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall({
    Key? key,
    this.onDrag,
    this.handlerWidget,
    required this.isDone,
    required this.active,
  });

  final Function? onDrag;
  final HandlerWidget? handlerWidget;
  final bool isDone;
  final bool active;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

enum HandlerWidget {
  HORIZONTAL,
  VERTICAL,
  CENTRAL,
  ROTATORY,
  SIZE,
  CUT,
  DONE,
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  double? initX;
  double? initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag!(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Visibility(
        visible: widget.isDone == false,
        child: Container(
            child: widget.handlerWidget == HandlerWidget.CENTRAL
                ? const MouseRegion(
              cursor: SystemMouseCursors.grab,
              child: Opacity(
                opacity: 0.6,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                ),
              ),
            )
                : widget.handlerWidget == HandlerWidget.ROTATORY
                ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              child: Center(
                child: Icon(
                  Icons.rotate_90_degrees_ccw,
                  size: 17,

                ),
              ),
              onPressed: () {},
            )
                : widget.handlerWidget == HandlerWidget.CUT
                ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffD82B2B),
                shape: const CircleBorder(),
              ),
              child: const Text(
                "X",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                showBlank(true);


                // showBlank(true);
                // hideBottomSheet(false);
              },
            )
                : widget.handlerWidget == HandlerWidget.SIZE
                ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.expand,
                color: Colors.black,
              ),
              onPressed: () {},
            )
                : widget.handlerWidget == HandlerWidget.DONE
                ? TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: const CircleBorder(),
              ),
              child: const Text(
                "✔️",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                isDone(true);
                textFieldActive(false);
                Navigator.pop(context);

                // showBlank(true);
                // hideBottomSheet(false);
              },
            )
                : const SizedBox()
          // child: widget.handlerWidget == HandlerWidget.VERTICAL ||
          //         widget.handlerWidget == HandlerWidget.HORIZONTAL
          //     ? Text("ANkit")
          //     : const SizedBox(),
        ),
      ),
    );
  }
}
