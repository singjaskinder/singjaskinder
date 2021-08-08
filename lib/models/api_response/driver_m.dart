class DriverM {
  String message;
  List<Details> details;

  DriverM({this.message, this.details});

  DriverM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      details = new List<Details>();
      json['data'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.details != null) {
      data['data'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int noOfRatings;
  int totalRating;
  bool isVerified;
  List<Null> jobs;
  bool isBanned;
  String sId;
  String name;
  String email;
  String phone;
  String password;
  String pin;
  Null image;
  List<Addresses> addresses;
  String fcmToken;
  String device;
  String deviceId;
  String build;
  List<PrimaryDocument> primaryDocument;
  List<SecondaryDocument> secondaryDocument;
  List<AdditionalDocument> additionalDocument;
  String createdAt;
  String updatedAt;
  int iV;

  Details(
      {this.noOfRatings,
      this.totalRating,
      this.isVerified,
      this.jobs,
      this.isBanned,
      this.sId,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.pin,
      this.image,
      this.addresses,
      this.fcmToken,
      this.device,
      this.deviceId,
      this.build,
      this.primaryDocument,
      this.secondaryDocument,
      this.additionalDocument,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Details.fromJson(Map<String, dynamic> json) {
    noOfRatings = json['no_of_ratings'];
    totalRating = json['total_rating'];
    isVerified = json['isVerified'];

    isBanned = json['is_banned'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    pin = json['pin'];
    image = json['image'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    fcmToken = json['fcm_token'];
    device = json['device'];
    deviceId = json['device_id'];
    build = json['build'];
    if (json['primary_document'] != null) {
      primaryDocument = new List<PrimaryDocument>();
      json['primary_document'].forEach((v) {
        primaryDocument.add(new PrimaryDocument.fromJson(v));
      });
    }
    if (json['secondary_document'] != null) {
      secondaryDocument = new List<SecondaryDocument>();
      json['secondary_document'].forEach((v) {
        secondaryDocument.add(new SecondaryDocument.fromJson(v));
      });
    }
    if (json['additional_document'] != null) {
      additionalDocument = new List<AdditionalDocument>();
      json['additional_document'].forEach((v) {
        additionalDocument.add(new AdditionalDocument.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_of_ratings'] = this.noOfRatings;
    data['total_rating'] = this.totalRating;
    data['isVerified'] = this.isVerified;

    data['is_banned'] = this.isBanned;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['pin'] = this.pin;
    data['image'] = this.image;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['fcm_token'] = this.fcmToken;
    data['device'] = this.device;
    data['device_id'] = this.deviceId;
    data['build'] = this.build;
    if (this.primaryDocument != null) {
      data['primary_document'] =
          this.primaryDocument.map((v) => v.toJson()).toList();
    }
    if (this.secondaryDocument != null) {
      data['secondary_document'] =
          this.secondaryDocument.map((v) => v.toJson()).toList();
    }
    if (this.additionalDocument != null) {
      data['additional_document'] =
          this.additionalDocument.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Addresses {
  String sId;
  Null address;
  Null state;
  Null city;
  int postalCode;
  Null country;

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

class PrimaryDocument {
  String sId;
  String drivingLicense;
  String passport;

  PrimaryDocument({this.sId, this.drivingLicense, this.passport});

  PrimaryDocument.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    drivingLicense = json['driving_license'];
    passport = json['passport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driving_license'] = this.drivingLicense;
    data['passport'] = this.passport;
    return data;
  }
}

class SecondaryDocument {
  String sId;
  String australianCitizenship;
  String australianVisa;
  String residenceProof;
  String bankCard;
  String medicare;
  String federalPoliceCheck;

  SecondaryDocument(
      {this.sId,
      this.australianCitizenship,
      this.australianVisa,
      this.residenceProof,
      this.bankCard,
      this.medicare,
      this.federalPoliceCheck});

  SecondaryDocument.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    australianCitizenship = json['australian_citizenship'];
    australianVisa = json['australian_visa'];
    residenceProof = json['residence_proof'];
    bankCard = json['bank_card'];
    medicare = json['medicare'];
    federalPoliceCheck = json['federal_police_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['australian_citizenship'] = this.australianCitizenship;
    data['australian_visa'] = this.australianVisa;
    data['residence_proof'] = this.residenceProof;
    data['bank_card'] = this.bankCard;
    data['medicare'] = this.medicare;
    data['federal_police_check'] = this.federalPoliceCheck;
    return data;
  }
}

class AdditionalDocument {
  String sId;
  String drivingHistory;

  AdditionalDocument({this.sId, this.drivingHistory});

  AdditionalDocument.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    drivingHistory = json['driving_history'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driving_history'] = this.drivingHistory;
    return data;
  }
}
