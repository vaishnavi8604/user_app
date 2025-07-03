import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_app/module/controller/details_screen_controller.dart';
import 'package:user_app/resources/strings.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final DetailsScreenController controller = Get.put(DetailsScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appStrings.userDetails),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(controller.userDeatils.value.photo??""),
              ),
              SizedBox(height: 16),
              Text(
                "${appStrings.name} ${controller.userDeatils.value.name?.toString()}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 8),
              Text('${appStrings.company} ${controller.userDeatils.value.company}',),
              SizedBox(height: 8),
              Text('${appStrings.email} ${controller.userDeatils.value.email}'),
              SizedBox(height: 8),
              Text('${appStrings.phone} ${controller.userDeatils.value.phone}'),
              SizedBox(height: 16),
              Card(
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appStrings.location,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 8),
                        Text('${appStrings.address} ${controller.userDeatils.value.address??""} ${controller.userDeatils.value.zip??""}'),
                        Text('${appStrings.state} ${controller.userDeatils.value.state??""}'),
                        Text('${appStrings.country} ${controller.userDeatils.value.country??""}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
