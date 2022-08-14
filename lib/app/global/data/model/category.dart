import 'package:amar_karigor/app/global/data/model/sub_category.dart';

class Category {
  int _id;
  String _name;
  String _icon;
  String? attributes;
  List<SubCategory> _subCategories;

  Category(this._id, this._name, this._icon, this._subCategories);

  int get id => _id;
  String get name => _name;
  String get icon => _icon;
  List<SubCategory> get subCategories => _subCategories;
}
