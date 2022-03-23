import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slaypay_cc/app/model/image_data.dart';
import 'package:slaypay_cc/app/model/pattern.dart';

class CardData {
  PatternData? patternData;
  Color? cardBg;
  ImageData? imageData;
  bool? isPatternEnabled;

  CardData(
      {this.patternData, this.cardBg, this.imageData, this.isPatternEnabled});

  CardData copyWith(
      {PatternData? patternData,
      Color? cardBg,
        ImageData? imageData,
      bool? isPatternEnabled}) {
    return CardData(
        patternData: patternData ?? this.patternData,
        cardBg: cardBg ?? this.cardBg,
        imageData: imageData ?? imageData,
        isPatternEnabled: isPatternEnabled ?? this.isPatternEnabled);
  }

  bool? get isPatternEnable => isPatternEnabled;

  set isPatternEnable(bool? value) {
    isPatternEnabled = value;
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
