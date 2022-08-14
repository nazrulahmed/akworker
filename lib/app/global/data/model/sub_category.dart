class SubCategory {
  int _id;
  String _name;
  String? attribute;

  SubCategory(this._id, this._name, this.attribute);

  get name => _name;
  get id => _id;
}
