class Service {
  int _id;
  String _name;
  double _price;
  int _catId;
  int _subCatId;
  String _icon;
  String _description;
  String? _attribute;
  String? _option;

  Service(this._id, this._name, this._price, this._catId, this._subCatId,
      this._icon, this._description, this._attribute,this._option);

  int get id => _id;
  int get catId => _catId;
  String get name => _name;
  double get price => _price;
  int get subCatId => _subCatId;
  String get icon => _icon;
  String get description => _description;
  String? get attribute => _attribute;
  String? get option => _option;

   Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'cat_id': catId,
      'name': name,
      'price': price,
      'sub_cat_id': subCatId,
      'icon':icon,
      'description':description,
      'attribute':attribute,
      'option':option
    };
  }
}
