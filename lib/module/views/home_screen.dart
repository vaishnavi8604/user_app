import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/module/controller/home_screen_controller.dart';
import 'package:user_app/module/model/user_model.dart';
import 'package:user_app/resources/strings.dart';
import 'package:user_app/routes/route_class.dart';
import 'package:user_app/utils/constant.dart';
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

      ),
      body: Column(
          children: [
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
                    return SingleChildScrollView(
                      controller: controller.listController.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (controller.lastViewedUser.value?.name ?? '').isNotEmpty
                          ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '${appStrings.lastuser}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ):SizedBox(),
                          (controller.lastViewedUser.value?.name ?? '').isNotEmpty
                                        ?  UserCard(
                              user: controller.lastViewedUser.value??UserModel(),
                              onTap: ()  {
                                controller.saveLastUser(controller.lastViewedUser.value??UserModel());
                                Get.toNamed(RoutesClass.gotoDetailsScreen(), arguments: {
                                  'data': controller.lastViewedUser.value??UserModel(),
                                });

                              },
                            ):  SizedBox(),

                          (controller.filteredUserList.isNotEmpty)
                              ?  Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text('${appStrings.user}',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                          ): SizedBox(),
                          ListView.builder(
                            itemCount: controller.filteredUserList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return UserCard(
                                user: controller.filteredUserList[index],
                                onTap: ()  {
                                  controller.saveLastUser(controller.filteredUserList[index]);
                                  Get.toNamed(RoutesClass.gotoDetailsScreen(), arguments: {
                                    'data': controller.filteredUserList[index],
                                  });

                                },
                              );
                            },
                          ),
                        ],
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}

