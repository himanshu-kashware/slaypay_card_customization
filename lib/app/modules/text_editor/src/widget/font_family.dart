
import 'package:flutter/material.dart';


import '../../text_editor_data.dart';
import '../font_option_model.dart';

class FontFamily extends StatefulWidget {
  final List<FontFamilyModel> fonts;

  FontFamily(this.fonts);

  @override
  _FontFamilyState createState() => _FontFamilyState();
}

class _FontFamilyState extends State<FontFamily> {
  final _scrollController = ScrollController();
  final double _height = 20.0;
  double scroll = 4;

  void _scrollToIndex(double index) {
    double maxPixel = _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels == maxPixel) {
      setState(() {
        scroll = 4;
      });
    } else {
      setState(() {
        scroll = scroll + 4;
      });
    }
    _scrollController.animateTo(_height * index,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
                children: widget.fonts
                    .map(
                      (fontModel) => _FontFamilyPicker(
                          fontModel.font, fontModel.isSelected),
                    )
                    .toList()),
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

class _FontFamilyPicker extends StatelessWidget {
  final String font;
  final bool isSelected;

  _FontFamilyPicker(this.font, this.isSelected);

  @override
  Widget build(BuildContext context) {
    //ankitsrz
    final fontOptionModel = TextEditorData.read(context).fontOptionModel;

    return GestureDetector(
      onTap: () {
        fontOptionModel.selectFontFamily(font);
      },
      child: Container(
        // width: 80,
        height: 40,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? Colors.red : Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              font,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontFamily: font,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
