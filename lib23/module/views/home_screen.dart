import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/module/controller/home_screen_controller.dart';
import 'package:user_app/resources/strings.dart';
import 'package:user_app/routes/route_class.dart';
import 'package:user_app/utils/utils.dart';
import 'package:user_app/widget/user_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(appStrings.appName),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              Utils.closeKeyboard(context);
              _showSortDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Utils.closeKeyboard(context);
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: (){
          Utils.closeKeyboard(context);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.searchTextEditingController.value,
                decoration: InputDecoration(
                  labelText: appStrings.searchLabel,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value){
                  controller.searchText.value = value;
                },
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getUserData();
                },
                child: Obx((){
                  if(controller.isLoading.value){
                    return SizedBox();
                  }
                  if (controller.userApiError.isNotEmpty) {
                    if (controller.userApiError.value.contains('SocketException') || controller.userApiError.value.contains('No internet')) {
                      return _buildInternetErrorWidget();
                    }
                    else{
                      return _buildErrorWidget(context);
                    }
                  }
                  if (controller.userList.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  else {
                    return ListView.builder(
                      controller: controller.listController.value,
                      itemCount: controller.userList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return UserCard(
                          user: controller.userList[index],
                          onTap: () {
                            Utils.closeKeyboard(context);
                            Get.toNamed(RoutesClass.gotoDetailsScreen(), arguments: {
                              'data': controller.userList[index],
                            });
                          },
                        );
                      },
                    );
                  }
                }),
              ),
            ),
            Obx(() => controller.isMoreDataAvailable.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()),

          ],
        ),
      ),
    );
  }
  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appStrings.sortBy),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(appStrings.ascending),
                onTap: () {
                  controller.sortUsers(true); // A-Z
                  Get.back();
                },
              ),
              ListTile(
                title: Text(appStrings.descending),
                onTap: () {
                  controller.sortUsers(false); // Z-A
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Obx(()=>AlertDialog(
              title: Text(appStrings.filterTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text(appStrings.all),
                    value: '',
                    groupValue: controller.genderFilter.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.genderFilter.value = value;
                      }
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(appStrings.male),
                    value: appStrings.male.toLowerCase(),
                    groupValue: controller.genderFilter.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.genderFilter.value = value;
                      }
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(appStrings.female),
                    value: appStrings.female.toLowerCase(),
                    groupValue: controller.genderFilter.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.genderFilter.value = value;
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text(appStrings.cancel),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: Text(appStrings.apply),
                  onPressed: () {
                    controller.getUserData();
                    Get.back();
                  },
                ),
              ],
            ));
          },
        );
      },
    );
  }
  Widget _buildInternetErrorWidget(){
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(Get.context!).size.height * 0.6,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off, size: 80, color: Colors.orange),
                SizedBox(height: 20),
                Text(
                  appStrings.noInternet,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  appStrings.checkConnection,
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text(appStrings.retry),
                  onPressed: () {
                    controller.userApiError.value = '';
                    controller.getUserData();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildErrorWidget(context){
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off, size: 80, color: Colors.redAccent),
              SizedBox(height: 16),
              Text(
                appStrings.somethingWrong,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                controller.userApiError.value,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  controller.userApiError.value = '';
                  controller.getUserData();
                },
                icon: Icon(Icons.refresh),
                label: Text(appStrings.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEmptyState(context){
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_off, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                appStrings.noData,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
               appStrings.adjustFilter,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  controller.searchTextEditingController.value.clear();
                  controller.searchText.value = '';
                  controller.genderFilter.value = '';
                  controller.getUserData();
                },
                icon: Icon(Icons.refresh),
                label: Text(appStrings.resetFilter),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

