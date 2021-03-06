import 'package:flutter/material.dart';

import '../../text_editor_data.dart';
import '../text_style_model.dart';

class TextAlignment extends StatelessWidget {
  final Widget? left;
  final Widget? center;
  final Widget? right;

  TextAlignment({this.left, this.center, this.right});

  void _onChangeAlignment(TextStyleModel textStyleModel) {
    switch (textStyleModel.textAlign) {
      case TextAlign.left:
        textStyleModel.editTextAlinment(TextAlign.center);
        break;
      case TextAlign.center:
        textStyleModel.editTextAlinment(TextAlign.right);
        break;
      default:
        textStyleModel.editTextAlinment(TextAlign.left);
    }
  }

  Widget _mapTextAlignToWidget(TextAlign align) {
    switch (align) {
      case TextAlign.left:
        return left ??
            const Icon(
              Icons.format_align_left,
              color: Colors.purple,
            );
      case TextAlign.center:
        return center ??
            const Icon(
              Icons.format_align_center,
              color: Colors.purple,
            );
      default:
        return right ??
            const Icon(
              Icons.format_align_right,
              color: Colors.purple,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = TextEditorData.of(context).textStyleModel;
    return GestureDetector(
      onTapUp: (_) => _onChangeAlignment(model),
      child: _mapTextAlignToWidget(model.textAlign!),
    );
  }
}
