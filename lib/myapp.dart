import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:slaypay_cc/app/routes/app_pages.dart';

import 'app/modules/card_home/views/card_home_view.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(const SlayPayCustomize());
//   });
// }

class SlayPayCustomize extends StatelessWidget {
  const SlayPayCustomize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return CardHomeView();

  }
}
