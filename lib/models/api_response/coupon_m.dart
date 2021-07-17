class CouponM {
  String message;
  List<Coupon> coupons;

  CouponM({this.message, this.coupons});

  CouponM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      coupons = new List<Coupon>();
      json['data'].forEach((v) {
        coupons.add(new Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.coupons != null) {
      data['data'] = this.coupons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupon {
  String sId;
  String description;
  int offValue;
  String offerCode;
  String expiration;
  String adminId;
  List<Users> users;
  String createdAt;
  String updatedAt;
  int iV;

  Coupon(
      {this.sId,
      this.description,
      this.offValue,
      this.offerCode,
      this.expiration,
      this.adminId,
      this.users,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    offValue = json['offValue'];
    offerCode = json['offerCode'];
    expiration = json['expiration'];
    adminId = json['adminId'];
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['offValue'] = this.offValue;
    data['offerCode'] = this.offerCode;
    data['expiration'] = this.expiration;
    data['adminId'] = this.adminId;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Users {
  String sId;
  String userId;

  Users({this.sId, this.userId});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    return data;
  }
}
