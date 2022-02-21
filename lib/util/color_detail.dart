import 'dart:math';

import 'package:flutter/material.dart';

class ColorDetail {
  bool _isSelected;
  late final Color _color;

  ColorDetail.name(this._isSelected, this._color);

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}

List<ColorDetail> getColorsList() {
  final List<ColorDetail> _colorList = [];
  for (int i = 0; i < 50; i++) {
    ColorDetail _color;
    if (i == 0) {
      _color = ColorDetail.name(true, Colors.white);
    } else {
      _color = ColorDetail.name(
          false, Colors.primaries[Random().nextInt(Colors.primaries.length)]);
    }

    _colorList.add(_color);
  }
  return _colorList;
}
