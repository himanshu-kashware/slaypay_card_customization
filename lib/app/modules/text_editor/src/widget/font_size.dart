
import 'package:flutter/material.dart';

import '../../text_editor_data.dart';

class FontSize extends StatelessWidget {
  final double minFontSize;
  final double maxFontSize;

  FontSize({required this.minFontSize, required this.maxFontSize});

  @override
  Widget build(BuildContext context) {
    final model = TextEditorData.of(context).textStyleModel;
    return RotatedBox(
      quarterTurns: 3,
      child: Slider(
        value: model.textStyle?.fontSize ?? minFontSize,
        min: minFontSize,
        max: maxFontSize,
        divisions: ((maxFontSize - minFontSize) * 10).toInt(),
        activeColor: Colors.red,
        inactiveColor: Colors.red.withOpacity(0.4),
        onChanged: (double value) => model.editFontSize(value),
      ),
    );
  }
}
