import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:user_app/resources/strings.dart';
import 'package:user_app/routes/route_class.dart';
import 'package:user_app/utils/app_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GlobalLoaderOverlay(
      overlayColor: Colors.black38,
      overlayHeight: 30,
      overlayWidth: 30,
      overlayWidgetBuilder: (context) {
        return Center(
          child: CircularProgressIndicator(color: Colors.indigo,),
        );
      },
      child: GetMaterialApp(
        title: appStrings.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        debugShowCheckedModeBanner: false,
        getPages: RoutesClass.routes,
        builder:(context,child){
          return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), child: child!);
        },
        initialRoute: RoutesClass.gotoHomeScreen(),
      ),
    );
  }
}

