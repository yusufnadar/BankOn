import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/const/app.dart';
import 'core/const/routing/pages.dart';
import 'core/const/routing/route_control.dart';
import 'core/const/themes.dart';
import 'core/init/database_helper_service.dart';
import 'core/init/locator_service.dart';
import 'core/init/theme_service.dart';

void main() async{
  await GetStorage.init();
  await Locator.setupLocator();
  await DatabaseHelperService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        initialRoute: Pages.splash,
        localizationsDelegates: localizationsDelegates,
        debugShowCheckedModeBanner: false,
        title: App.title,
        getPages: Routes.getPages,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeService.getTheme(),
      ),
    );
  }
}


var localizationsDelegates = const [
  GlobalMaterialLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
  DefaultWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];