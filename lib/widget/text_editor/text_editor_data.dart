import 'package:flutter/material.dart';
import 'src/font_option_model.dart';
import 'src/text_style_model.dart';

class TextEditorData extends InheritedWidget {
  const TextEditorData({
    Key? key,
    required Widget child,
    required this.textStyleModel,
    required this.fontOptionModel,
    // required this.fontOptionModelTwo,
    // required this.textStyleModelTwo,
    // required this.fontOptionModelThree,
    // required this.textStyleModelThree,
  }) : super(key: key, child: child);

  final TextStyleModel textStyleModel;
  // final TextStyleModelTwo textStyleModelTwo;
  // final TextStyleModelThree textStyleModelThree;
  final FontOptionModel fontOptionModel;
  // final FontOptionModelTwo fontOptionModelTwo;
  // final FontOptionModelThree fontOptionModelThree;

  static TextEditorData of(BuildContext context) {
    final TextEditorData? result =
        context.dependOnInheritedWidgetOfExactType<TextEditorData>();
    assert(result != null, 'No TextEditorData found in context');

    return result!;
  }

  static TextEditorData read(BuildContext context) {
    final TextEditorData? result =
        context.findAncestorWidgetOfExactType<TextEditorData>();
    assert(result != null, 'No TextEditorData found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // Not the most efficient but we can safely assume that if we got rebuilt
    // it's because a value in either textStlyeModel or fontOptionModel was changed.
    // (This is the only time TextEditor rebuild itslef).
    return true;
  }
}
