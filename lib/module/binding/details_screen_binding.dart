
import 'package:get/get.dart';
import 'package:user_app/module/controller/details_screen_controller.dart';

class DetailsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsScreenController());
  }
}
