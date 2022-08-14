class User {
  final String uid;
  final String token;
  String? _phone;
  String? _firstName;
  String? _lastName;
  String? _address;
  String? _email;

  User(this.uid, this.token);


  String? get phone => this._phone;
  String? get firstName => this._firstName;
  String? get lastName => this._lastName;
  String? get address => this._address;
  String? get email => this._email;

  set setPhone(String num) {
    this._phone = num;
  }

  set setFirstName(String firstName) {
    this._firstName = firstName;
  }

  set setLastName(String lastName) {
    this._lastName = lastName;
  }

  set setAddress(String address) {
    this._address = address;
  }

  set setEmail(String email) {
    this._email = email;
  }

  factory User.fromJson(String uid, String token, dynamic json) {
    return User(uid, token)
      .._address = json['address'] as String?
      .._email = json['email'] as String?
      .._firstName = json['first_name'] as String?
      .._phone = json['phone'] as String;
  }

  bool profileCompleted() {
    return firstName != null && address != null && email != null;
  }
}
