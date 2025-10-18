import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:user_app/module/model/user_model.dart';
import 'package:user_app/repository/user_list_repository.dart';

class HomeScreenController extends GetxController {

  final listController = ScrollController().obs;
  var searchTextEditingController = TextEditingController().obs;
  final _apiService = UserListRepository();
  var userListModel = UserModel().obs;
  var isLoading = false.obs;
  var userApiError = ''.obs;
  var pageNo = 1.obs;
  var results = 20.obs;
  var isMoreDataAvailable = false.obs;
  void setUserListModel(UserModel data) => userListModel.value = data;
  void setUserApiError(String error) => userApiError.value = error;
  var originalUserList = List<Results>.empty(growable: true).obs;
  var userList = List<Results>.empty(growable: true).obs;
  var genderFilter = ''.obs;
  var searchText = ''.obs;
  var isAscending = true.obs;

  @override
  void onInit() {
    getUserData();
    paginateTask();
    debounce(searchText, (_) => applySearchAndSort(), time: Duration(milliseconds: 300));
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
    _apiService.getUserList(pageNo.value.toString(), results.value.toString(),genderFilter.value).then((value) {
        setUserListModel(value);
        originalUserList.clear();
        userList.clear();
        originalUserList.addAll(value.results as Iterable<Results>);
        applySearchAndSort();
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
    _apiService.getUserList(pageNo.value.toString(), results.value.toString(),genderFilter.value).then((value) {
        if (value.results?.isNotEmpty??false) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
          pageNo--;
        }
        originalUserList.addAll(value.results as Iterable<Results>);
        applySearchAndSort();
        isMoreDataAvailable(false);
    }).onError((error, stackTrace) {
      isMoreDataAvailable(false);
      setUserApiError(error.toString());
    }).whenComplete(() {
      isMoreDataAvailable(false);
    });
  }
  void applySearchAndSort() {
    final query = searchText.value.toLowerCase();
    List<Results> tempList = [...originalUserList];

    if (query.isNotEmpty) {
      tempList = tempList.where((user) {
        final fullName = "${user.name?.first ?? ''} ${user.name?.last ?? ''}".toLowerCase();
        final email = user.email?.toLowerCase()??"";
        return fullName.contains(query) || email.contains(query);
      }).toList();
    }

    tempList.sort((a, b) {
      final nameA = a.name?.first?.toLowerCase() ?? '';
      final nameB = b.name?.first?.toLowerCase() ?? '';
      return isAscending.value
          ? nameA.compareTo(nameB)
          : nameB.compareTo(nameA);
    });

    userList.assignAll(tempList);
  }

  void sortUsers(bool ascending) {
    isAscending.value = ascending;
    applySearchAndSort();
  }

}