import 'package:amar_karigor/app/global/config/app_style.dart';
import 'package:amar_karigor/app/modules/location/model/city.dart';
import 'package:amar_karigor/app/modules/location/model/country.dart';
import 'package:amar_karigor/app/modules/location/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  @override
  Widget build(BuildContext context) {
    print('build called');
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return SizedBox();
          } else {
            print('else called ${controller.currentLocationType}');
            return Column(
              children: [
                searchBar(),
                GetBuilder(builder: (LocationController controller) {
                  if (controller.currentLocationType == LOCATION_TYPE.COUNTRY) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: controller.filterCountries.length,
                          itemBuilder: (context, index) {
                            return countryItem(
                                controller.filterCountries[index]);
                          }),
                    );
                  } else if (controller.currentLocationType ==
                      LOCATION_TYPE.CITY) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: controller.filterCities.length,
                          itemBuilder: (context, index) {
                            return cityItem(controller.filterCities[index]);
                          }),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: controller.filterAreas.length,
                          itemBuilder: (context, index) {
                            return areaItem(controller.filterAreas[index]);
                          }),
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }

  Widget areaItem(String area) {
    return GestureDetector(
        onTap: () {
          controller.setArea(area);
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 2),
            color: Colors.white,
            child: ListTile(
                leading: Icon(Icons.location_city), title: Text(area))));
  }

  Widget cityItem(City city) {
    return GestureDetector(
        onTap: () {
          controller.setCity(city);
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: 2,
          ),
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.location_city),
            title: Text(city.name),
          ),
        ));
  }

  Widget countryItem(Country country) {
    return GestureDetector(
      onTap: () {
        controller.setCountry(country);
      },
      child: Container(
          margin: EdgeInsets.only(
            bottom: 2,
          ),
          color: Colors.white,
          child: ListTile(
              leading: Icon(Icons.location_on), title: Text(country.name))),
    );
  }

  Widget searchBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            if (controller.currentLocationType == controller.startingLocation) {
              controller.goBack(finish: true);
            } else {
              controller.goBack();
            }
          },
          icon: Icon(Icons.arrow_back_sharp, color: MyColors.colorPrimary)),
      title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: kIsWeb ? 9 : 0),
              child: TextFormField(
                  controller: controller.searchInputController,
                  onChanged: (val) {
                    controller.performSearch(val);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Type here...")))),
    );
  }
}
