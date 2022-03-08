import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slaypay_cc/app/model/pattern.dart';

class CardData {
    PatternData? patternData;
     Color? cardBg;
    XFile? image;
    double? imagePosX;
   double? imagePosY;

  CardData(
      { this.patternData,
          this.cardBg,
         this.image,
         this.imagePosX,
          this.imagePosY});

  CardData copyWith({
    PatternData? patternData,
    Color? cardBg,
    XFile? image,
    double? imagePosX,
    double? imagePosY,
  }) {
    return CardData(
      patternData: patternData ?? this.patternData,
      cardBg: cardBg ?? this.cardBg,
      image: image ?? this.image,
      imagePosX: imagePosX ?? this.imagePosX,
      imagePosY: imagePosY ?? this.imagePosY,
    );
  }

  double? get imagePosYGet => imagePosY;

  set imagePosYSet(double? value) {
    imagePosY = value;
  }

  double? get imagePosXGet => imagePosX;

  set imagePosXSet(double? value) {
    imagePosX = value;
  }

  XFile? get imageGet => image;

  set imageSet(XFile? value) {
    image = value;
  }

  Color? get cardBgGet => cardBg;

  set cardBgSet(Color? value) {
    cardBg = value;
  }

  PatternData? get patternDataGet => patternData;

  set patternDataSet(PatternData? value) {
    patternData = value;
  }
}
