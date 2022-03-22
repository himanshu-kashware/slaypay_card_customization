import 'package:flutter/material.dart';

class TextData {
  String textString;
  Color textColor;
  double textPositionX;
  double textPositionY;
  double textRotationAngle;

  TextData copyWith({
    String? textString,
    Color? textColor,
    double? textPositionX,
    double? textPositionY,
    double? textRotationAngle,
  }) {
    return TextData(
      textString: textString ?? this.textString,
      textColor: textColor ?? this.textColor,
      textPositionX: textPositionX ?? this.textPositionX,
      textPositionY: textPositionY ?? this.textPositionY,
      textRotationAngle: textRotationAngle ?? this.textRotationAngle,
    );
  }

  TextData({
    required this.textString,
    required this.textColor,
    required this.textPositionX,
    required this.textPositionY,
    required this.textRotationAngle,
  });

  Map<String, dynamic> toMap() {
    return {
      'textString': textString,
      'textColor': textColor,
      'textPositionX': textPositionX,
      'textPositionY': textPositionY,
      'textRotationAngle': textRotationAngle,
    };
  }

  factory TextData.fromMap(Map<String, dynamic> map) {
    return TextData(
      textString: map['textString'] as String,
      textColor: map['textColor'] as Color,
      textPositionX: map['textPositionX'] as double,
      textPositionY: map['textPositionY'] as double,
      textRotationAngle: map['textRotationAngle'] as double,
    );
  }
}
