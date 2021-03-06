library text_editor;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/widget/text_editor/src/font_option_model.dart';
import 'package:slaypay_cc/widget/text_editor/src/text_style_model.dart';
import 'package:slaypay_cc/widget/text_editor/text_editor_data.dart';
import '../resizable_text.dart';

RxBool isDone = true.obs;
RxInt activeField = 1.obs;
RxBool showOne = true.obs;
RxBool showTwo = true.obs;
RxBool showThree = true.obs;
RxBool textFieldActive = true.obs;
RxBool fontTypeActive = true.obs;

class TextEditor extends StatefulWidget {
  /// Editor's font families
  final List<String> fonts;

  /// After edit process completed, [onEditCompleted] callback will be called.
  final void Function(TextStyle, TextAlign, String) onEditCompleted;

  /// [onTextAlignChanged] will be called after [textAlingment] prop has changed
  final ValueChanged<TextAlign>? onTextAlignChanged;

  /// [onTextStyleChanged] will be called after [textStyle] prop has changed
  final ValueChanged<TextStyle>? onTextStyleChanged;

  /// [onTextChanged] will be called after [text] prop has changed
  final ValueChanged<String>? onTextChanged;

  /// The text alignment
  final TextAlign? textAlingment;

  /// The text style
  final TextStyle? textStyle;

  /// Widget's background color
  final Color? backgroundColor;

  /// Editor's palette colors
  final List<Color>? paletteColors;

  /// Editor's default text
  final String text;

  /// Decoration to customize the editor
  final EditorDecoration? decoration;

  final double? minFontSize;
  final double? maxFontSize;

  /// Create a [TextEditor] widget
  ///
  /// [fonts] list of font families that you want to use in editor.
  ///
  /// After edit process completed, [onEditCompleted] callback will be called
  /// with new [textStyle], [textAlingment] and [text] value
  TextEditor({
    required this.fonts,
    required this.onEditCompleted,
    this.paletteColors,
    this.backgroundColor,
    this.text = '',
    this.textStyle,
    this.textAlingment,
    this.minFontSize = 1,
    this.maxFontSize = 100,
    this.onTextAlignChanged,
    this.onTextStyleChanged,
    this.onTextChanged,
    this.decoration,
  });

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  late TextStyleModel _textStyleModel;
  late FontOptionModel _fontOptionModel;

  // late TextStyleModelTwo _textStyleModelTwo;
  // late FontOptionModelTwo _fontOptionModelTwo;
  // late TextStyleModelThree _textStyleModelThree;
  // late FontOptionModelThree _fontOptionModelThree;
  late Widget _doneButton;

  @override
  void initState() {
    _textStyleModel = TextStyleModel(
      widget.text,
      textStyle: widget.textStyle,
      textAlign: widget.textAlingment,
    );
    // _textStyleModelTwo = TextStyleModelTwo(
    //   widget.text,
    //   textStyle: widget.textStyle,
    //   textAlign: widget.textAlingment,
    // );
    // _textStyleModelThree = TextStyleModelThree(
    //   widget.text,
    //   textStyle: widget.textStyle,
    //   textAlign: widget.textAlingment,
    // );
    _fontOptionModel = FontOptionModel(
      _textStyleModel,
      widget.fonts,
      colors: widget.paletteColors,
    );
    // _fontOptionModelTwo = FontOptionModelTwo(
    //   _textStyleModelTwo,
    //   widget.fonts,
    //   colors: widget.paletteColors,
    // );
    // _fontOptionModelThree = FontOptionModelThree(
    //   _textStyleModelThree,
    //   widget.fonts,
    //   colors: widget.paletteColors,
    // );

    // Rebuild whenever a value changes
    _textStyleModel.addListener(() {
      setState(() {});
    });
    // _textStyleModelTwo.addListener(() {
    //   setState(() {});
    // });
    // _textStyleModelThree.addListener(() {
    //   setState(() {});
    // });

    // Rebuild whenever a value changes
    _fontOptionModel.addListener(() {
      setState(() {});
    });
    // _fontOptionModelTwo.addListener(() {
    //   setState(() {});
    // });
    // _fontOptionModelThree.addListener(() {
    //   setState(() {});
    // });

    // Initialize decorator
    _doneButton = widget.decoration?.doneButton ??
        Text('Done', style: TextStyle(color: Colors.black, fontSize: 14));

    super.initState();
  }

  void _editCompleteHandler() {
    widget.onEditCompleted(
      _textStyleModel.textStyle!,
      _textStyleModel.textAlign!,
      _textStyleModel.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextEditorData(
        textStyleModel: _textStyleModel,
        fontOptionModel: _fontOptionModel,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Stack(
              children: [
                Obx(
                  () => Visibility(
                    visible: showOne.value,
                    child: Positioned(
                      child: Center(
                        child: ResizebleTextWidget(
                          isDone: isDone.value,
                          isText: true,
                          width: 150,
                          height: 50,
                          child: TextField(
                            controller: TextEditingController()
                              ..text = _textStyleModel.text,

                            onChanged: (value) {
                              _textStyleModel.text = value;
                            },
                            onTap: () {
                              activeField(0);
                              textFieldActive(true);
                              isDone(false);
                            },
                            maxLines: null,
                            style: _textStyleModel.textStyle,
                            textAlign: _textStyleModel.textAlign!,
                            autofocus: false,
                            cursorColor: Colors.white,

                            decoration: const InputDecoration(
                              hintText: "Enter Text",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Decoration to customize text alignment widgets' design.
///
/// Pass your custom widget to `left`, `right` and `center` to customize their design
class AlignmentDecoration {
  /// Left alignment widget
  final Widget? left;

  /// Center alignment widget
  final Widget? center;

  /// Right alignment widget
  final Widget? right;

  AlignmentDecoration({this.left, this.center, this.right});
}

/// Decoration to customize text background widgets' design.
///
/// Pass your custom widget to `enable`, and `disable` to customize their design
class TextBackgroundDecoration {
  /// Enabled text background widget
  final Widget? enable;

  /// Disabled text background widget
  final Widget? disable;

  TextBackgroundDecoration({this.enable, this.disable});
}

/// Decoration to customize the editor
///
/// By using this class, you can customize the text editor's design
class EditorDecoration {
  /// Done button widget
  final Widget? doneButton;
  final AlignmentDecoration? alignment;

  /// Text background widget
  final TextBackgroundDecoration? textBackground;

  /// Font family switch widget
  final Widget? fontFamily;

  /// Color palette switch widget
  final Widget? colorPalette;

  EditorDecoration({
    this.doneButton,
    this.alignment,
    this.fontFamily,
    this.colorPalette,
    this.textBackground,
  });
}
