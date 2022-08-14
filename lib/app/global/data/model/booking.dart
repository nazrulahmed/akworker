class Booking {
  String? _id;
  String? _uid;
  int _serviceId=0;
  String? _serviceName;
  String? _bookingDate;
  String? _bookingTime;
  String? _created;
  double _totalToPay = 0.0;
  String? _bookingType;
  String? _attribute;
  String? _status;
  String? _icon;

  Booking(
      {String? id,
      String? uid,
      int serviceId=0,
      String? serviceName,
      String? bookingDate,
      String? bookingTime,
      String? created,
      double totalToPay = 0.0,
      String? bookingType,
      String? attribute,
      String? status,String? icon}) {
    if (id != null) {
      this._id = id;
    }
    if (uid != null) {
      this._uid = uid;
    }
    
    this._serviceId = serviceId;
    
    if (serviceName != null) {
      this._serviceName = serviceName;
    }
    if (bookingDate != null) {
      this._bookingDate = bookingDate;
    }
    if (bookingTime != null) {
      this._bookingTime = bookingTime;
    }
    if (created != null) {
      this._created = created;
    }
    
      this._totalToPay = totalToPay;
    
    if (bookingType != null) {
      this._bookingType = bookingType;
    }
    if (attribute != null) {
      this._attribute = attribute;
    }
    if (status != null) {
      this._status = status;
    }
    if (icon != null) {
      this._icon = icon;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get uid => _uid;
  set uid(String? uid) => _uid = uid;

  int get serviceId => _serviceId;
  set serviceId(int serviceId) => _serviceId = serviceId;

  String? get serviceName => _serviceName;
  set serviceName(String? serviceName) => _serviceName = serviceName;

  String? get bookingDate => _bookingDate;
  set bookingDate(String? bookingDate) => _bookingDate = bookingDate;

  String? get bookingTime => _bookingTime;
  set bookingTime(String? bookingTime) => _bookingTime = bookingTime;

  String? get created => _created;
  set created(String? created) => _created = created;
  double get totalToPay => _totalToPay;
  set totalToPay(double totalToPay) => _totalToPay = totalToPay;
  String? get bookingType => _bookingType;
  set bookingType(String? bookingType) => _bookingType = bookingType;
  String? get attribute => _attribute;
  set attribute(String? attribute) => _attribute = attribute;
  String? get status => _status;
  set status(String? status) => _status = status;

  String? get icon => _icon;
  set icon(String? icon) => _icon = icon;

  Booking.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uid = json['uid'];
    _serviceId = json['service_id'];
    _serviceName = json['service_name'];
    _bookingDate = json['booking_date'];
    _bookingTime = json['booking_time'];
    _created = json['created'];
    _totalToPay = json['total_to_pay'];
    _bookingType = json['booking_type'];
    _attribute = json['attribute'];
    _status = json['status'];
    _icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uid'] = this._uid;
    data['service_id'] = this._serviceId;
    data['service_name'] = this._serviceName;
    data['booking_date'] = this._bookingDate;
    data['booking_time'] = this._bookingTime;
    data['created'] = this._created;
    data['total_to_pay'] = this._totalToPay;
    data['booking_type'] = this._bookingType;
    data['attribute'] = this._attribute;
    data['status'] = this._status;
    data['icon'] = this._icon;
    return data;
  }
}
