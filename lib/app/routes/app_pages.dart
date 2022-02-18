import 'package:get/get.dart';
import 'package:slaypay_cc/app/modules/card_home/bindings/card_home_binding.dart';
import 'package:slaypay_cc/app/modules/card_home/views/card_home_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CARD_VIEW;

  static final routes = [
    GetPage(
      name: _Paths.CARD_VIEW,
      page: () => CardHomeView(),
      binding: CardHomeBinding(),
    ),
  ];
}
