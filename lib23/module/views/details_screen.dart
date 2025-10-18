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
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(controller.userDeatils.value.picture?.large??""),
              ),
              SizedBox(height: 16),
              Text(
                "${controller.userDeatils.value.name?.title} ${controller.userDeatils.value.name?.first} ${controller.userDeatils.value.name?.last}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
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
                        Text('${appStrings.city} ${controller.userDeatils.value.location?.city??""}'),
                        Text('${appStrings.state} ${controller.userDeatils.value.location?.state??""}'),
                        Text('${appStrings.country} ${controller.userDeatils.value.location?.country??""}'),
                      ],
                    ),
                  ),
                ),
              ),
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
                          appStrings.dob,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: 8),
                        Text(
                            '${DateFormat("d MMMM y").format( DateTime.parse('${controller.userDeatils.value.dob?.date}').toLocal())} (${appStrings.age} ${controller.userDeatils.value.dob?.age})'),
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
