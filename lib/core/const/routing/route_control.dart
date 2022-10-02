import 'package:get/get.dart';
import '../../../view/pages/account_details.dart';
import '../../../view/pages/home_page.dart';
import '../../../view/pages/splash.dart';
import '../../init/bindings.dart';
import 'pages.dart';

class Routes {
  static final getPages = [
    GetPage(
      name: Pages.splash,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Pages.accountDetails,
      page: () => const AccountDetails(),
      binding: AccountDetailsBinding(),
    ),
    GetPage(
      name: Pages.homePage,
      page: () => const HomePage(),
      binding: HomePageBinding(),
    ),
  ];
}
