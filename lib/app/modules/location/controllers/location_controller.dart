import 'package:amar_karigor/app/global/util/app_pref.dart';
import 'package:amar_karigor/app/modules/location/model/city.dart';
import 'package:amar_karigor/app/modules/location/model/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LOCATION_TYPE { COUNTRY, CITY, AREA }

class LocationController extends GetxController {
  LOCATION_TYPE currentLocationType = LOCATION_TYPE.COUNTRY;
  LOCATION_TYPE startingLocation = LOCATION_TYPE.COUNTRY;
  TextEditingController searchInputController = TextEditingController();
  String? selectedCountry;
  String? selectedCity;
  String? selectedArea;

  var currentLocation = "Set your location".obs;

  List<City> cities = [];
  List<Country> countries = [];
  List<String> areas = [];

  List<City> filterCities = [];
  List<Country> filterCountries = [];
  List<String> filterAreas = [];

  List<Map<String, dynamic>> userInterections = [];

  @override
  void onReady() {
    super.onReady();
  }

  void defineLocationType() {
    print('define Location called');
    if (countries.length == 1) {
      print('if 1 ');
      if (countries[0].cities.length == 1) {
        print('if 2 ');
        currentLocationType = LOCATION_TYPE.AREA;
        startingLocation = LOCATION_TYPE.AREA;
        areas.clear();
        filterAreas.addAll(countries[0].cities[0].areas);
        areas.addAll(countries[0].cities[0].areas);
      } else {
        print('else 1 ');
        currentLocationType = LOCATION_TYPE.CITY;
        startingLocation = LOCATION_TYPE.CITY;
        cities.clear();
        cities.addAll(countries[0].cities);
        filterCities.addAll(countries[0].cities);
        print(cities.toString());
      }
    }
  }

  void setCountry(Country country) {
    userInterections.add(
        {"keyword": searchInputController.text,
         "state": currentLocationType});
    searchInputController.clear();
    selectedCountry = country.name;
    currentLocationType = LOCATION_TYPE.CITY;
    filterCities.clear();
    filterCities.addAll(country.cities);
    update();
  }

  void performSearch(String val) {
    if (currentLocationType == LOCATION_TYPE.COUNTRY) {
      filterCountries.clear();
      for (Country country in countries) {
        if (country.name.toLowerCase().contains(val)) {
          filterCountries.add(country);
        }
      }
    } else if (currentLocationType == LOCATION_TYPE.CITY) {
      filterCities.clear();
      for (City city in cities) {
        if (city.name.toLowerCase().contains(val)) {
          filterCities.add(city);
        }
      }
    } else {
      filterAreas.clear();
      for (String area in areas) {
        if (area.toLowerCase().contains(val)) {
          filterAreas.add(area);
        }
      }
    }
    update();
  }

  void goBack({bool finish: false}) {
    if (finish) {
      Get.back();
    } else {
      Map<String, dynamic> interaction = userInterections.last;
      LOCATION_TYPE lastState = interaction['state'];
      String lastKeyword = interaction['keyword'];
      searchInputController.text = lastKeyword;
      currentLocationType = lastState;
      userInterections.removeLast();
      update();
    }
  }

  void setCity(City city) {
    userInterections.add(
        {"keyword": searchInputController.text, "state": currentLocationType});
    searchInputController.clear();
    selectedCity = city.name;
    currentLocationType = LOCATION_TYPE.AREA;
    filterAreas.clear();
    filterAreas.addAll(city.areas);
    update();
  }

  void setArea(String area) async {
    selectedArea = area;
    if (selectedArea != null ||
        selectedCity != null ||
        selectedCountry != null) {
      currentLocation.value = "";
    }
    if (selectedArea != null) {
      currentLocation.value += selectedArea!;
    }
    if (selectedCity != null) {
      currentLocation.value += ", " + selectedCity!;
    }
    if (selectedCountry != null) {
      currentLocation.value += ", " + selectedCountry!;
    }
    AppPref? pref = await AppPref.instance;
    pref!.setLocation(currentLocation.value);
    Get.back();
  }
}
