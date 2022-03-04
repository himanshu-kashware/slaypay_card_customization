import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';


import 'package:slaypay_cc/widget/text_properties.dart';

enum WidgetSets { TEXT, IMAGE }

class TextOverImage extends StatefulWidget {


  final TextProperties? textProperties;
  final Function(int? index) onTapWidget;
  final int? index;
  final Function(int)? tabSelected;
  final VoidCallback? tickMark;

  TextOverImage(
      {
        required this.onTapWidget,
        this.textProperties,
        this.index,
        this.tabSelected,
        this.tickMark});

  @override
  _TextOverImageState createState() => _TextOverImageState();
}

class _TextOverImageState extends State<TextOverImage> {
  Offset offset = Offset.zero;

  final _textEditingController = TextEditingController();
  bool isFocus = true;

  @override
  Widget build(BuildContext context) {
    return  ResizebleWidget(
      isSelected: isFocus,
      angle: widget.textProperties!.angle,
      isTabSelected: (bool value) {
        setState(() {
          isFocus = value;
        });
        widget.tickMark!();
      },
      top: widget.textProperties!.positionX,
      left: widget.textProperties!.positionY,
      onFinish: (dx, dy) {
        setState(() {
          widget.textProperties!.positionX = dx;
          widget.textProperties!.positionY = dy;
        });
      },
      onTapCallback: () {
        widget.onTapWidget(widget.index);
      },
      child: FocusWidget.builder(
        context,
        builder: (_, focusNode) {
          return GestureDetector(
            onTap: () {
              focusNode.requestFocus();
            },
            child: Focus(
              focusNode: focusNode,
              child: AutoSizeTextField(
                onTap: () {
                  widget.tabSelected!(widget.index!);
                  setState(() {
                    isFocus = true;
                  });
                },
                controller: _textEditingController,
                style: widget.textProperties!.font_family != null
                    ? widget.textProperties!.font_family.copyWith(
                    color: widget.textProperties!.fontColor,
                    fontSize: widget.textProperties!.fontSize)
                    : const TextStyle(),
                textAlign: TextAlign.left,
                wrapWords: true,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                    hintText: "New Text",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(5)),
                maxLines: 3,
              ),
            ),
          );
        },
        onLostFocus: (_, focusNode) {
          // Get.snackbar('Lost focus', "ajhvs");
        },
        showFocusArea: false,
      ),
    );

  }
}
closeKeyboard() {
  FocusScope.of(Get.context!).requestFocus(FocusNode());
}

class ResizebleWidget extends StatefulWidget {
  ResizebleWidget(
      {required this.child,
        required this.onTapCallback,
        required this.isSelected,
        required this.top,
        required this.left,
        required this.isTabSelected,
        required this.onFinish,
        required this.angle});
  bool isSelected;
  final Widget child;
  final Function(double, double) onFinish;
  final VoidCallback onTapCallback;
  double top;
  double left;
  double angle;
  final Function(bool) isTabSelected;
  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 30.0;

class _ResizebleWidgetState extends State<ResizebleWidget> {
  double height = 50;
  double width = 200;
  final double _angle = 0.0;
  final double _startAngle = 0.0;

  Offset offset = Offset.zero;
  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  final kInnerDecoration = BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(0),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.black, Colors.white]),
    border: Border.all(
      color: Colors.black,
    ),
    borderRadius: BorderRadius.circular(0),
  );
  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: <Widget>[
          Positioned(
            top: widget.top,
            left: widget.left,
            child: GestureDetector(
              onPanUpdate: (details) {
                closeKeyboard();
                setState(() {
                  offset = Offset(offset.dx + details.delta.dx,
                      offset.dy + details.delta.dy);
                  widget.top = offset.dy + details.delta.dy;
                  widget.left = offset.dx + details.delta.dx;
                });
                widget.onFinish(widget.top, widget.left);
              },
              child: Container(
                height: height,
                width: width,
                decoration: widget.isSelected
                    ? kInnerDecoration
                    : const BoxDecoration(),
                child: widget.child,
              ),
            ),
          ),
          // top left
          Positioned(
            top: widget.top - ballDiameter / 2,
            left: widget.left - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/resizer.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;
                var newHeight = height - 2 * mid;
                var newWidth = width - 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  widget.top = widget.top + mid;
                  widget.left = widget.left + mid;
                });
                widget.onFinish(widget.top, widget.left);
              },
            )
                : const SizedBox(),
          ),
          // top middle
          Positioned(
            top: widget.top - ballDiameter / 2,
            left: widget.left + width / 2 - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/resize_mark.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy) {
                var newHeight = height - dy;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  widget.top = widget.top + dy;
                });
                widget.onFinish(widget.top, widget.left);
              },
            )
                : const SizedBox(),
          ),
          // top right
          Positioned(
            top: widget.top - ballDiameter / 2,
            left: widget.left + width - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/close.svg',
              isClickable: true,
              onTap: () {
                widget.onTapCallback();
              },
              onDrag: (dx, dy) {
                var mid = (dx + (dy * -1)) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  widget.top = widget.top - mid;
                  widget.left = widget.left - mid;
                });
                widget.onFinish(widget.top, widget.left);
              },
            )
                : const SizedBox(),
          ),

          // center right
          Positioned(
            top: widget.top + height / 2 - ballDiameter / 2,
            left: widget.left + width - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/resize_mark.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy) {
                var newWidth = width + dx;

                setState(() {
                  width = newWidth > 0 ? newWidth : 0;
                });
              },
            )
                : const SizedBox(),
          ),
          // bottom right
          Positioned(
            top: widget.top + height - ballDiameter / 2,
            left: widget.left + width - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/tick_mark.svg',
              isClickable: true,
              onTap: () {
                widget.onFinish(widget.top, widget.left);
                widget.isTabSelected(false);
              },
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  widget.top = widget.top - mid;
                  widget.left = widget.left - mid;
                  widget.onFinish(widget.top, widget.left);
                });
              },
            )
                : const SizedBox(),
          ),
          // bottom center
          Positioned(
            top: widget.top + height - ballDiameter / 2,
            left: widget.left + width / 2 - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/resize_mark.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy) {
                var newHeight = height + dy;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                });
              },
            )
                : const SizedBox(),
          ),
          // bottom left
          Positioned(
            top: widget.top + height - ballDiameter / 2,
            left: widget.left - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/resizer.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy) {
                var mid = ((dx * -1) + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  widget.top = widget.top - mid;
                  widget.left = widget.left - mid;
                  widget.onFinish(widget.top, widget.left);
                });
              },
            )
                : const SizedBox(),
          ),
          //left center
          Positioned(
            top: widget.top + height / 2 - ballDiameter / 2,
            left: widget.left - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/resize_mark.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy, details) {
                var newWidth = width - dx;

                setState(() {
                  width = newWidth > 0 ? newWidth : 0;
                  widget.left = widget.left + dx;
                  widget.onFinish(widget.top, widget.left);
                });
              },
            )
                : const SizedBox(),
          ),
          // center center
          Positioned(
            top: widget.top + height / 2 - ballDiameter / 2,
            left: widget.left + width / 2 - ballDiameter / 2,
            child: widget.isSelected
                ? ManipulatingBall(
              directory: 'assets/images/card_assets/pan_mark.svg',
              isClickable: false,
              onTap: () {},
              onDrag: (dx, dy) {
                setState(() {
                  widget.top = widget.top + dy;
                  widget.left = widget.left + dx;
                });
                widget.onFinish(widget.top, widget.left);
              },
            )
                : const SizedBox(),
          ),
        ],
      );

  }
}

class ManipulatingBall extends StatefulWidget {
  ManipulatingBall(
      {Key? key,
        required this.onDrag,
        required this.isClickable,
        required this.onTap,
        required this.directory});

  final Function onDrag;
  bool isClickable;
  final VoidCallback onTap;
  final String? directory;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
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
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: widget.isClickable ? null : _handleDrag,
      onPanUpdate: widget.isClickable ? null : _handleUpdate,
      onTap: widget.isClickable ? widget.onTap : null,
      child: Container(
        width: ballDiameter,
        height: ballDiameter,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: widget.directory != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            widget.directory!,
            fit: BoxFit.fill,
          ),
        )
            : const SizedBox(),
      ),
    );
  }
}

// class TransformDemo extends StatelessWidget {
//   final Widget children;
//   TransformDemo({required this.children});
//   @override
//   Widget build(BuildContext context) {
//     final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
//     return MatrixGestureDetector(
//       onMatrixUpdate: (m, tm, sm, rm) {
//         notifier.value = m;
//       },
//       clipChild: false,
//       child: AnimatedBuilder(
//         animation: notifier,
//         builder: (ctx, child) {
//           return Transform(
//               transform: notifier.value,
//               child: Transform.scale(scale: .5, child: children));
//         },
//       ),
//     );
//   }
// }
