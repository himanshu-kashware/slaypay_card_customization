import 'package:flutter/material.dart';

class TextProperties {
  Color _fontColor;
  double _angle;
  double _fontSize;
  TextStyle _font_family;
  double _positionX;
  double _positionY;
  TextProperties(this._fontColor, this._fontSize, this._font_family,
      this._angle, this._positionX, this._positionY);

  TextStyle get font_family => _font_family;

  set font_family(TextStyle value) {
    _font_family = value;
  }

  Color get fontColor => _fontColor;

  set fontColor(Color value) {
    _fontColor = value;
  }

  double get positionY => _positionY;

  set positionY(double value) {
    _positionY = value;
  }

  double get positionX => _positionX;

  set positionX(double value) {
    _positionX = value;
  }

  double get angle => _angle;

  set angle(double value) {
    _angle = value;
  }

  double get fontSize => _fontSize;

  set fontSize(double value) {
    _fontSize = value;
  }
}
