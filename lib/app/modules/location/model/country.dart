import 'city.dart';

class Country {
  String _name;
  List<City> _cities;
  

  Country(this._name, this._cities);

  String get name => _name;
  List<City> get cities => _cities;

}
