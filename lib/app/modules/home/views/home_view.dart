import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/config/app_style.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Ami Karigor',
            style: TextStyle(
                color: MyColors.colorPrimary, fontWeight: FontWeight.bold)),
        actions: [
          Obx(
            () => controller.isChangingAvailableStatus.value?Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            ): Switch(
              value: controller.availableStatus.value == 1,
              onChanged: (v) async {
                if (v) {
                  await controller.changeAvailableStatus(1);
                
                } else {
                  await controller.changeAvailableStatus(0);
                }
              },
              activeColor: Colors.green,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Today\'s work',
                        style: MyTextStyle.textBlackLargeBold,
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => Text(
                          '${controller.totalTask.value}',
                          style: MyTextStyle.textBlackLargeBold,
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Today\'s income',
                        style: MyTextStyle.textBlackLargeBold,
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => Text(
                          '${controller.totalIncome.value}',
                          style: MyTextStyle.textBlackLargeBold,
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          ),
          SizedBox(height: 24),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffdddddd))),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          backgroundColor: controller.availableStatus == 1
                              ? Colors.green
                              : Colors.grey,
                          maxRadius: 8,
                        ),
                      ),
                      SizedBox(width: 12),
                      Obx(
                        () => controller.availableStatus == 1
                            ? Text('You\'re available now',
                                style: MyTextStyle.textBlackLargeBold)
                            : Text('You\'re offline now',
                                style: MyTextStyle.textBlackLargeBold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}
