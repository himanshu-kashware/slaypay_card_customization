import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slaypay_cc/generated/assets.dart';

class MakeFilter extends StatelessWidget {
  final String? image;
  final Function(Color color)? onFilterSelected;
  final ScrollController _controller = ScrollController();

  MakeFilter({Key? key, required this.image, this.onFilterSelected})
      : super(key: key);

  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: 56,
                width: 56,
                child: Center(
                    child: SvgPicture.asset(
                  Assets.cardImagesArrowLeft,
                  height: 20,
                )),
                // child: Center(child: Icon(Icons.arrow_back_ios_rounded)),
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => Container(
                    width: 56,
                    color: Colors.grey.shade200,
                    height: 56,
                    child: Builder(builder: (_) {
                      return GestureDetector(
                        onTap: () => onFilterSelected!(index == 0
                            ? Colors.transparent
                            : _filters[index - 1]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: index == 0
                              ? Center(
                                  child: SvgPicture.asset(
                                    Assets.cardImagesBlock,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  child: kIsWeb
                                      ? Image.network(
                                          "$image",
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.color,
                                          color: _filters[index - 1],
                                        )
                                      : Image.file(
                                          File(
                                            "$image",
                                          ),
                                          fit: BoxFit.cover,
                                          colorBlendMode: BlendMode.color,
                                          color: _filters[index - 1],
                                        ),
                                ),
                        ),
                      );
                    })),
                itemCount: _filters.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _controller.animateTo(50,
                    duration: const Duration(seconds: 1), curve: Curves.easeIn);
              },
              child: SizedBox(
                height: 56,
                width: 56,
                child: Center(
                    child: SvgPicture.asset(
                  Assets.cardImagesArrowRight,
                  height: 20,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
