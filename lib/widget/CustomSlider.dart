import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatelessWidget {
  final String title;
  final double value;
  final double min = 0;
  final double max;
  final Function(dynamic value)? onChanged;

  const CustomSlider(
      {Key? key,
      required this.title,
      required this.value,
      this.onChanged,
      required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 6),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          SfSlider(
            min: 0.0,
            max: max,
            activeColor: AppColors.accentColor,
            inactiveColor: const Color(0x20707070),
            value: value,
            thumbIcon: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                // child: Icon(
                //   Icons.arrow_forward_ios_rounded,
                //   color: AppColors.white,
                // ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/arrow_right.svg",
                    color: Colors.white,
                    height: 20,
                  ),
                ),
              ),
            ),
            minorTicksPerInterval: 1,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
