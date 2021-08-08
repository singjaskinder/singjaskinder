class UserM {
  String message;
  List<UserData> userData;

  UserM({this.message, this.userData});

  UserM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      userData = new List<UserData>();
      json['data'].forEach((v) {
        userData.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userData != null) {
      data['data'] = this.userData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String id;
  String sId;
  String profileImage;
  bool mobileVerified;
  bool emailVerified;
  int noOfRatings;
  double totalRating;
  bool isRestricted;
  String email;
  String phone;
  String name;
  String fcmToken;
  String token;
  String device;
  String deviceId;
  String build;
  String stripeCustomerId;
  List<Addresses> addresses;
  String createdAt;
  String updatedAt;

  UserData(
      {this.id,
      this.sId,
      this.profileImage,
      this.mobileVerified,
      this.emailVerified,
      this.noOfRatings,
      this.totalRating,
      this.isRestricted,
      this.email,
      this.phone,
      this.name,
      this.fcmToken,
      this.token,
      this.device,
      this.deviceId,
      this.build,
      this.stripeCustomerId,
      this.addresses,
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['_id'];
    profileImage = json['image'];
    mobileVerified = json['mobile_verified'];
    emailVerified = json['email_verified'];
    noOfRatings = json['no_of_ratings'];
    totalRating = json['total_rating']?.toDouble();
    isRestricted = json['is_restricted'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    fcmToken = json['fcm_token'];
    token = json['token'];
    device = json['device'];
    deviceId = json['device_id'];
    build = json['build'];
    stripeCustomerId = json['stripe_customer_id'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['_id'] = this.sId;
    data['image'] = this.profileImage;
    data['mobile_verified'] = this.mobileVerified;
    data['email_verified'] = this.emailVerified;
    data['no_of_ratings'] = this.noOfRatings;
    data['total_rating'] = this.totalRating?.toDouble();
    data['is_restricted'] = this.isRestricted;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['fcm_token'] = this.fcmToken;
    data['token'] = this.token;
    data['device'] = this.device;
    data['device_id'] = this.deviceId;
    data['build'] = this.build;
    data['stripe_customer_id'] = this.stripeCustomerId;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Addresses {
  String sId;
  String address;
  String state;
  String city;
  int postalCode;
  String country;

  Addresses(
      {this.sId,
      this.address,
      this.state,
      this.city,
      this.postalCode,
      this.country});

  Addresses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}
