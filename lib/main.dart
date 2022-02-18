import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

