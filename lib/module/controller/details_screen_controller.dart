import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:user_app/module/model/user_model.dart';


class DetailsScreenController extends GetxController {
  var userDeatils = UserModel().obs;

  @override
  void onInit() {
    Get.context?.loaderOverlay.show();
    userDeatils.value = Get.arguments['data'];
    Get.context?.loaderOverlay.hide();
    super.onInit();
  }

}