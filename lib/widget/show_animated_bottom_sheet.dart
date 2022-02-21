import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/constants/app_colors.dart';
import 'package:slaypay_cc/generated/assets.dart';

Widget showAnimatedBottomSheet({required childWidget}) {
  return AnimatedContainer(
    duration: const Duration(seconds: 1),
    child: childWidget,
  );
}
