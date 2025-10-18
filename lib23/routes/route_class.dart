import 'package:get/get.dart';
import 'package:user_app/module/binding/details_screen_binding.dart';
import 'package:user_app/module/binding/home_screen_binding.dart';
import 'package:user_app/module/views/details_screen.dart';
import 'package:user_app/module/views/home_screen.dart';


class RoutesClass {
  //RoutesName
  static String home = '/homeScreen';
  static String details = '/detailsScreen';


  //RoutesMethod
  static String gotoHomeScreen() => home;
  static String gotoDetailsScreen() => details;


  //RoutesPage
  static List<GetPage> routes = [
    GetPage(
        name: home,
        page: () =>  HomeScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
        binding: HomeScreenBinding()
    ),
    GetPage(
        name: details,
        page: () =>  DetailsScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
        binding: DetailsScreenBinding()
    ),
  ];
}
