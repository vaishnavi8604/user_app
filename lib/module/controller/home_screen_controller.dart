import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:user_app/module/model/user_model.dart';
import 'package:user_app/repository/user_list_repository.dart';
import 'package:user_app/utils/constant.dart';
import 'package:user_app/utils/utils.dart';

class HomeScreenController extends GetxController {

  final listController = ScrollController().obs;
  final _apiService = UserListRepository();
  var userListModel = UserModel().obs;
  var isLoading = false.obs;
  var userApiError = ''.obs;
  var pageNo = 1.obs;
  var results = 10.obs;
  var isMoreDataAvailable = false.obs;
  void setUserListModel(UserModel data) => userListModel.value = data;
  void setUserApiError(String error) => userApiError.value = error;
  var userList = List<UserModel>.empty(growable: true).obs;
  var lastViewedUser = Rxn<UserModel>();

  @override
  void onInit() {
    getUserData();
    paginateTask();
    super.onInit();
  }

  void paginateTask() {
    listController.value.addListener(() {
      if (listController.value.position.pixels ==
          (listController.value.position.maxScrollExtent)) {
        isMoreDataAvailable(true);
        pageNo++;
        getMoreUserData();
      }
    });
  }

  Future<void> getUserData() async {
    pageNo.value = 1;
    isLoading(true);
    Get.context?.loaderOverlay.show();
    _apiService.getUserList(pageNo.value.toString(), results.value.toString()).then((value) {

        userList.clear();
      userList.addAll(value as Iterable<UserModel>);
        loadLastUser();
    }).onError((error, stackTrace) {
      Get.context?.loaderOverlay.hide();
      isLoading(false);
      setUserApiError(error.toString());
    }).whenComplete(() {
      isLoading(false);
      Get.context?.loaderOverlay.hide();
    });
  }
  Future<void> getMoreUserData() async {
    _apiService.getUserList(pageNo.value.toString(), results.value.toString()).then((value) {
        if (value.isNotEmpty??false) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
          pageNo--;
        }
        userList.addAll(value as Iterable<UserModel>);
        loadLastUser();
        isMoreDataAvailable(false);
        
    }).onError((error, stackTrace) {
      isMoreDataAvailable(false);
      setUserApiError(error.toString());
    }).whenComplete(() {
      isMoreDataAvailable(false);
    });
  }

  void saveLastUser(UserModel user) async {
    await Utils.setSharedPrefValue(AppConst.UserName,user.name??'');
    lastViewedUser.value = user;
    loadLastUser();
  }
  void loadLastUser() async {
    final name = await Utils.getSharedPrefValue(AppConst.UserName);
    if (name != null) {
      final user = userList.firstWhereOrNull((u) => u.name == name);
      print("luser.name ${name}");
        if (user != null) {
          userList.removeWhere((u) => u.name == name);
          lastViewedUser.value = user;
        }
        else {
        final lastUser = UserModel(id: -1, name: name);
        lastViewedUser.value = lastUser;
      }
    }
  }

}