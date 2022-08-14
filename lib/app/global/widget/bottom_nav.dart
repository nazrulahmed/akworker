import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:amar_karigor/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Widget getBottomNavbar(HomeController controller) {
  return Obx(() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(width: 1.0, color: Color(0xffeeeeee)))),
      child: SalomonBottomBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          
          controller.changePage(index);
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: MyColors.colorPrimary,
            unselectedColor: Colors.grey[400],
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(
              Icons.headphones,
            ),
            title: Text("Support"),
            selectedColor: MyColors.colorPrimary,
            unselectedColor: Colors.grey[400],
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.bookmarks),
            title: Text("Booking"),
            selectedColor: MyColors.colorPrimary,
            unselectedColor: Colors.grey[400],
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text("More"),
            selectedColor: MyColors.colorPrimary,
            unselectedColor: Colors.grey[400],
          ),
        ],
      ),
    );
  });
}
