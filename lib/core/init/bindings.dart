import 'package:get/get.dart';
import '../../view/pages/account_details.dart';
import '../../view/pages/home_page.dart';
import '../../view/pages/splash.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

class AccountDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailsController());
  }
}

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut(() => HomePageController());
  }
}
