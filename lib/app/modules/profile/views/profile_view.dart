import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:amar_karigor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions:  [
            GetBuilder(builder: (ProfileController profileController)=> !controller.user.profileCompleted()?SizedBox(): IconButton(
                onPressed: () {
                  Get.toNamed(Routes.UPDATE_PROFILE);
                },
                icon: Icon(Icons.edit))),
           
          ],
        ),
        body: GetBuilder(builder: (ProfileController profileController)=>!controller.user.profileCompleted()
            ? Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Your profile is not completed yet! Please complete your profile',
                      style: MyTextStyle.textBlackMediumBold),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () =>   Get.toNamed(Routes.UPDATE_PROFILE),
                    child: Text('Update profile'),
                    style: MyButtonStyle.submitButton,
                  ),
                )
              ])
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xffeeeeee)),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              readOnly: true,
                              controller: controller.nameInputFieldController,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                prefixIcon: Icon(Icons.person),
                                border: InputBorder.none,
                                hintText: 'Enter your name',
                                labelText: 'Name',
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (num) {},
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xffeeeeee)),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              readOnly: true,
                              controller:
                                  controller.addressInputFieldController,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                prefixIcon: Icon(Icons.apartment),
                                border: InputBorder.none,
                                hintText: 'Enter your address',
                                labelText: 'Address',
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (num) {},
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xffeeeeee)),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              readOnly: true,
                              controller: controller.emailInputFieldController,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                prefixIcon: Icon(Icons.mail),
                                border: InputBorder.none,
                                hintText: 'Enter your email',
                                labelText: 'Email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (num) {},
                              validator: (val) {
                                if (!GetUtils.isEmail(val!)) {
                                  return controller
                                      .generateErrorMsg('Enter a valid email');
                                }
                                return '';
                              },
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xffeeeeee)),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              readOnly: true,
                              controller: controller.phoneInputFieldController,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                prefixIcon: Icon(Icons.mobile_friendly,
                                    color: MyColors.colorPrimary),
                                border: InputBorder.none,
                                labelStyle: MyTextStyle.textBlackMediumBold,
                                enabled: false,
                                labelText: 'Phone',
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (num) {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )));  }
}
