library text_editor;

import 'dart:math';
import 'package:get/get.dart';
import 'package:slaypay_cc/app/modules/text_editor/src/font_option_model.dart';
import 'package:slaypay_cc/app/modules/text_editor/src/text_style_model.dart';
import 'package:slaypay_cc/app/modules/text_editor/text_editor_data.dart';
import '../../../widget/resizeable_text.dart';
import 'src/widget/color_palette.dart';
import 'src/widget/font_family.dart';
import 'package:flutter/material.dart';
import 'src/widget/font_option_switch.dart';
import 'src/widget/font_size.dart';
import 'src/widget/text_alignment.dart';
import 'src/widget/text_background_color.dart';

RxBool isDone = true.obs;
RxInt activeField = 0.obs;
RxBool showOne = false.obs;
RxBool showTwo = false.obs;
RxBool showThree = false.obs;
RxBool textFieldActive = false.obs;
RxBool fontTypeActive = false.obs;
RxBool fontColorActive = false.obs;
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
  late Widget _doneButton;

  @override
  void initState() {
    _textStyleModel = TextStyleModel(
      widget.text,
      textStyle: widget.textStyle,
      textAlign: widget.textAlingment,
    );
    _fontOptionModel = FontOptionModel(
      _textStyleModel,
      widget.fonts,
      colors: widget.paletteColors,
    );

    // Rebuild whenever a value changes
    _textStyleModel.addListener(() {
      setState(() {});
    });

    // Rebuild whenever a value changes
    _fontOptionModel.addListener(() {
      setState(() {});
    });

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
    return TextEditorData(
      textStyleModel: _textStyleModel,
      fontOptionModel: _fontOptionModel,
      child: Container(
        // padding: EdgeInsets.only(right: 10, left: 10),
        color: Colors.transparent,
        child: Center(
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Row(
              //   children: [
              //     // Expanded(child: Container()),
              //     // Expanded(
              //     //   flex: 3,
              //     //   child: Obx(
              //     //     () => isDone.value == false
              //     //         ? Row(
              //     //             mainAxisAlignment: MainAxisAlignment.center,
              //     //             children: [
              //     //               TextAlignment(
              //     //                 left: widget.decoration?.alignment?.left,
              //     //                 center:
              //     //                     widget.decoration?.alignment?.center,
              //     //                 right: widget.decoration?.alignment?.right,
              //     //               ),
              //     //               SizedBox(width: 20),
              //     //               FontOptionSwitch(
              //     //                 fontFamilySwitch:
              //     //                     widget.decoration?.fontFamily,
              //     //                 colorPaletteSwitch:
              //     //                     widget.decoration?.colorPalette,
              //     //               ),
              //     //               SizedBox(width: 20),
              //     //               TextBackgroundColor(
              //     //                 enableWidget: widget
              //     //                     .decoration?.textBackground?.enable,
              //     //                 disableWidget: widget
              //     //                     .decoration?.textBackground?.disable,
              //     //               ),
              //     //             ],
              //     //           )
              //     //         : const SizedBox(
              //     //             height: 25,
              //     //           ),
              //     //   ),
              //     // ),

              //     // Expanded(
              //     //   child: Obx(
              //     //     () => isDone.value == false
              //     //         ? Align(
              //     //             alignment: Alignment.centerRight,
              //     //             child: GestureDetector(
              //     //               onTap: _editCompleteHandler,
              //     //               child: _doneButton,
              //     //             ),
              //     //           )
              //     //         : const SizedBox(
              //     //             height: 16,
              //     //           ),
              //     //   ),
              //     // ),
              //   ],
              // ),

              Obx(
                () => Visibility(
                  visible: showOne.value,
                  child: Positioned(
                    child: Transform.rotate(
                      angle: -pi / angle.value,
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
                              // isDone(false);
                            },
                            onTap: () {
                              activeField(0);
                              textFieldActive(true);
                              isDone(false);
                            },
                            maxLines: 1,
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
              ),
              Obx(
                () => isDone.value == false && fontTypeActive.value == true
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: Get.width,
                          height: 108,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffFBFBFB), Color(0xffE0E0E0)],
                          )),
                          child: _fontOptionModel.status ==
                                  FontOptionStatus.fontFamily
                              ? Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      FontFamily(
                                          _fontOptionModel.fonts,
                                       ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : ColorPalette(_fontOptionModel.colors!),
                        ),
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => isDone.value == false && fontColorActive.value == true
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: Get.width,
                          height: 108,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffFBFBFB), Color(0xffE0E0E0)],
                          )),
                          child: _fontOptionModel.status ==
                                  FontOptionStatus.fontFamily
                              ? Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ColorPalette(_fontOptionModel.colors!),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : FontFamily(
                                  _fontOptionModel.fonts,

                                ),
                        ),
                      )
                    : const SizedBox(),
              ),
              // Obx(
              //   () => isDone.value == false && emojiActiva.value == true
              //       ? Container(
              //           width: Get.width,
              //           decoration: const BoxDecoration(
              //               gradient: LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [Color(0xffFBFBFB), Color(0xffE0E0E0)],
              //           )),
              //           child: _fontOptionModel.status ==
              //                   FontOptionStatus.fontFamily
              //               ? Center(
              //                   child: Column(
              //                     children: [
              //                       const SizedBox(
              //                         height: 30,
              //                       ),
              //                       SizedBox(
              //                         width: Get.width,
              //                         height: 60,
              //                         child: Center(
              //                           child: ListView.builder(
              //                               scrollDirection: Axis.horizontal,
              //                               itemCount:
              //                                   Strings.emojies.length - 6,
              //                               shrinkWrap: true,
              //                               itemBuilder: (context, index) {
              //                                 return GestureDetector(
              //                                   onTap: () {
              //                                     currentEmoji(
              //                                         Strings.emojies[index]);
              //                                   },
              //                                   child: Center(
              //                                     child: Padding(
              //                                       padding:
              //                                           const EdgeInsets.all(
              //                                               8.0),
              //                                       child: Text(
              //                                         Strings.emojies[index],
              //                                         style: const TextStyle(
              //                                             fontSize: 36),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 );
              //                               }),
              //                         ),
              //                       ),
              //                       const SizedBox(
              //                         height: 20,
              //                       ),
              //                     ],
              //                   ),
              //                 )
              //               : FontFamily(_fontOptionModel.fonts),
              //         )
              //       : const SizedBox(),
              // ),
            ],
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
