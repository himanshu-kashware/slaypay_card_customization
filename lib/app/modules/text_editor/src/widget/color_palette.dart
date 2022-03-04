
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../text_editor_data.dart';

class ColorPalette extends StatefulWidget {
  final List<Color> colors;

  ColorPalette(this.colors);

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  final _scrollController = ScrollController();
  final double _height = 40.0;
  double scroll = 4;
  void _scrollToIndex(double index) {
    setState(() {
      scroll = scroll + 4;
    });
    _scrollController.animateTo(_height * index,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    //ankitsrz
    final textStyleModel = TextEditorData.of(context).textStyleModel;
    return Row(
      children: [
        Expanded(
          flex: 0,
          child: GestureDetector(
            onTap: () {
              _scrollToIndex(-scroll);
            },
            child: SizedBox(
              height: 56,
              width: 56,
              // child: Center(child: Icon(Icons.arrow_back_ios_rounded)),
              child: Center(
                  child: Icon(
                Icons.arrow_left,
                    size: 20,
              )),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              children: [
                // Container(
                //   width: 40,
                //   height: 40,
                //   margin: EdgeInsets.only(right: 14),
                //   decoration: BoxDecoration(
                //     color: textStyleModel.textStyle?.color,
                //     border: Border.all(color: Colors.white, width: 1.5),
                //     borderRadius: BorderRadius.circular(100),
                //   ),
                //   child: Center(
                //     child: Icon(
                //       Icons.colorize,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),

                ...widget.colors.map((color) => _ColorPicker(color)).toList(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: GestureDetector(
            onTap: () {
              _scrollToIndex(scroll);
            },
            child: SizedBox(
              height: 56,
              width: 56,
              // child: Center(child: Icon(Icons.arrow_forward_ios_rounded)),
              child: Center(
                  child: Icon(
                Icons.arrow_right,
                size: 20,
              )),
            ),
          ),
        ),
      ],
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final Color color;

  _ColorPicker(this.color);

  @override
  Widget build(BuildContext context) {
    final textStyleModel = TextEditorData.read(context).textStyleModel;


    return GestureDetector(
      onTap: () {
        textStyleModel.editTextColor(color);

      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.only(right: 15, left: 15),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
