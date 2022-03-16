// import 'package:card_customization/text_editor/src/font_option_model_two.dart';
// import 'package:card_customization/text_editor/text_style_model_two.dart';
// import 'package:flutter/material.dart';

// import 'src/font_option_model.dart';
// import 'src/text_style_model.dart';

// class TextEditorDataTwo extends InheritedWidget {
//   const TextEditorDataTwo({
//     Key? key,
//     required Widget child,
//     required this.textStyleModel,
//     required this.fontOptionModel,
//   }) : super(key: key, child: child);

//   final TextStyleModelTwo textStyleModel;
//   final FontOptionModelTwo fontOptionModel;

//   static TextEditorDataTwo of(BuildContext context) {
//     final TextEditorDataTwo? result =
//         context.dependOnInheritedWidgetOfExactType<TextEditorDataTwo>();
//     assert(result != null, 'No TextEditorData found in context');

//     return result!;
//   }

//   static TextEditorDataTwo read(BuildContext context) {
//     final TextEditorDataTwo? result =
//         context.findAncestorWidgetOfExactType<TextEditorDataTwo>();
//     assert(result != null, 'No TextEditorData found in context');

//     return result!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // Not the most efficient but we can safely assume that if we got rebuilt
//     // it's because a value in either textStlyeModel or fontOptionModel was changed.
//     // (This is the only time TextEditor rebuild itslef).
//     return true;
//   }
// }
