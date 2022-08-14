import 'package:flutter/material.dart';

class TabBarHeader extends StatelessWidget implements PreferredSizeWidget {
  const TabBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Booking'),
      bottom: const TabBar(
        indicatorColor: Colors.white,
        tabs: [
         // Tab(text: 'My cart'),
          Tab(text: 'Incomplete'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 110.0);
}
