// import 'package:card_customization/text_editor/text_style_model_three.dart';
// import 'package:card_customization/text_editor/text_style_model_two.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'text_style_model.dart';

// enum FontOptionStatusThree { colorPalette, fontFamily }

// class FontFamilyModelThree {
//   final String font;
//   bool isSelected = false;

//   FontFamilyModelThree(this.font, this.isSelected);
// }

// class FontOptionModelThree extends ChangeNotifier {
//   final TextStyleModelThree textStyleModel;
//   FontOptionStatusThree status = FontOptionStatusThree.fontFamily;

//   // Font family options
//   late List<FontFamilyModelThree> fonts;
//   late String selectedFont;

//   // Font color options
//   List<Color>? colors;
//   // late Color pickedColor;

//   FontOptionModelThree(this.textStyleModel, List<String> fonts, {this.colors}) {
//     // Set default selected font
//     selectedFont = textStyleModel.textStyle?.fontFamily ?? fonts[0];

//     // Map fonts to fontFamilyModel
//     this.fonts = fonts
//         .map((font) => FontFamilyModelThree(font, font == selectedFont))
//         .toList();

//     // Set default colors
//     colors = colors ??
//         [
//           Colors.black,
//           Colors.white,
//           Color(int.parse('0xffEA2027')),
//           Color(int.parse('0xff006266')),
//           Color(int.parse('0xff1B1464')),
//           Color(int.parse('0xff5758BB')),
//           Color(int.parse('0xff6F1E51')),
//           Color(int.parse('0xffB53471')),
//           Color(int.parse('0xffEE5A24')),
//           Color(int.parse('0xff009432')),
//           Color(int.parse('0xff0652DD')),
//           Color(int.parse('0xff9980FA')),
//           Color(int.parse('0xff833471')),
//           Color(int.parse('0xff112CBC4')),
//           Color(int.parse('0xffFDA7DF')),
//           Color(int.parse('0xffED4C67')),
//           Color(int.parse('0xffF79F1F')),
//           Color(int.parse('0xffA3CB38')),
//           Color(int.parse('0xff1289A7')),
//           Color(int.parse('0xffD980FA'))
//         ];

//     // Set default picked color
//     // pickedColor = textStyleModel.textStyle?.color ?? colors![0];
//     // Set new text color
//     // textStyleModel.editTextColor(textStyleModel.textStyle?.color ?? colors![0]);
//   }

//   void selectFontFamily(String value) {
//     textStyleModel.changeFontFamily(value);

//     // Set new selected font
//     fonts = fonts
//         .map<FontFamilyModelThree>((fontModel) =>
//             FontFamilyModelThree(fontModel.font, fontModel.font == value))
//         .toList();

//     notifyListeners();
//   }

//   // Set new text color
//   void pickColor(Color value) => textStyleModel.editTextColor(value);

//   void changeFontOptionStatus(FontOptionStatusThree value) {
//     status = value == FontOptionStatusThree.fontFamily
//         ? FontOptionStatusThree.colorPalette
//         : FontOptionStatusThree.fontFamily;

//     notifyListeners();
//   }
// }
