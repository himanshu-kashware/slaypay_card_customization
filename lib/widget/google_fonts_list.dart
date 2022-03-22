import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SlayPayGoogleFonts {
  late final TextStyle _font;
  bool _isSelected;
  late final String _name;

  SlayPayGoogleFonts.name(this._font, this._isSelected, this._name);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  TextStyle get font => _font;

  set font(TextStyle value) {
    _font = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}

getFontsList() {
  final List<SlayPayGoogleFonts> _fonts = [
    SlayPayGoogleFonts.name(GoogleFonts.getFont('Lato'), true, 'Lato'),
    SlayPayGoogleFonts.name(GoogleFonts.getFont('Poppins'), false, 'Poppins'),
    SlayPayGoogleFonts.name(
        GoogleFonts.getFont('Comfortaa'), false, 'Comfortaa'),
    SlayPayGoogleFonts.name(
        GoogleFonts.getFont('Droid Sans'), false, 'DroidSerif'),
    SlayPayGoogleFonts.name(GoogleFonts.getFont('Rubik'), false, 'Rubik'),
    SlayPayGoogleFonts.name(GoogleFonts.getFont('Oswald'), false, 'Oswald'),
    SlayPayGoogleFonts.name(GoogleFonts.getFont('Lobster'), false, 'Lobster'),
  ];

  return _fonts;
}
