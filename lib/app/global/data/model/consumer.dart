class Consumer {
  String _name;
  String _address;
  String _phone;
  String _email;

  Consumer(this._name,this._address,this._phone,this._email);

  Map<String,String>toJSON(){
    return {
      "consumer_name": _name,
      "consumer_address": _address,
      "consumer_phone": _phone,
      "consumer_email": _email,

    };
  }

}
