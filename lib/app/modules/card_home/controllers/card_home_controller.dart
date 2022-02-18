import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slaypay_cc/generated/assets.dart';

class CardHomeController extends GetxController {
  final cardStack = RxList<List<Widget>>().obs;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}


showCustomDialog(){
  showDialog(
    context: Get.context!,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Scaffold(
        backgroundColor:
        Colors.transparent.withOpacity(0.4),
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.white,
              width: 349,
              height: 300,
              child: Column(
                // mainAxisAlignment:
                //     MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 549,
                      color: const Color(0xffF7CCD6),
                      child: Image.asset(
                        Assets.imagesBin,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Are you sure you want to",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "delete your progress",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 24.0, right: 24.0),
                      child: Text(
                        "By proceeding you will lost all the design you have created yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff7886B4),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 140,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.w600,
                                  color:
                                  Color(0xff60184B),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {




                          },
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(5),
                            child: Container(
                              color:
                              const Color(0xff60184B),
                              height: 40,
                              width: 140,
                              child: const Center(
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                  ]),
            ),
          ),
        ),
      ),
    ),
  );
}
