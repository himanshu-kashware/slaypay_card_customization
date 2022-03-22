import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:slaypay_cc/widget/keymotion_gesture_detector.dart';
import "dart:math" as math;
class MovableText extends StatefulWidget {
  double xPosition;

  double yPosition;

  Color color;

  MovableText(
      {required this.xPosition, required this.yPosition, required this.color});

  @override
  _MovableTextState createState() => _MovableTextState();
}

class _MovableTextState extends State<MovableText> {
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _sessionOffset = Offset.zero;
  final textController = TextEditingController();

  double _scale = 1.0;
  double _initialScale = 1.0;

  double lastRotation=0.0;

  @override
  Widget build(BuildContext context) {
    return KeymotionGestureDetector(
      onRotationUpdate: (details) {
        setState(() {
          // 2.
          final angleDegrees = (details.rotationAngle * 180 ~/ math.pi).abs();
          lastRotation = details.rotationAngle;
          // 3.

        });
      },
      child: GestureDetector(
        onScaleStart: (details) {
          _initialFocalPoint = details.focalPoint;
          _initialScale = _scale;
        },
        onScaleUpdate: (details) {
          setState(() {
            _sessionOffset = details.focalPoint - _initialFocalPoint;
            _scale = _initialScale * details.scale;
          });
        },
        onScaleEnd: (details) {
          setState(() {
            _offset += _sessionOffset;
            _sessionOffset = Offset.zero;
          });
        },
        child: Transform.rotate(
          angle: lastRotation,
          child: Transform.translate(
            offset: _offset + _sessionOffset,
            child: Transform.scale(
              scale: _scale,
              child: AutoSizeTextField(
                autofocus: true,
                maxLines: null,
                minFontSize: 40,
                expands: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                decoration: const InputDecoration(border: InputBorder.none),
                controller: textController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
