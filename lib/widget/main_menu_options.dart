import 'package:flutter/material.dart';
import 'package:slaypay_cc/constants/app_colors.dart';

class MainMenuOptions extends StatelessWidget {
  final VoidCallback onTap;

  final IconData iconData;
  final String title;

   const MainMenuOptions(
      {required this.onTap, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      splashColor: AppColors.accentColor,
      child: Column(
        children: [
          Icon(iconData, color: AppColors.grey),
          Text(
            title,
            style: const TextStyle(color: AppColors.grey),
          )
        ],
      ),
    );
  }
}
