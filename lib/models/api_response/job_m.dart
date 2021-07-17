class JobM {
  String message;
  List<Jobs> jobs;

  JobM({this.message, this.jobs});

  JobM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      jobs = new List<Jobs>();
      json['data'].forEach((v) {
        jobs.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.jobs != null) {
      data['data'] = this.jobs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  bool fastDelivery;
  bool sendNoitification;
  String sId;
  PickLocation pickLocation;
  String pickAddress;
  PickLocation dropLocation;
  String dropAddress;
  String jobType;
  String packageTitle;
  String packageDescription;
  int noOfItem;
  double packageSize;
  double packageWeight;
  int extraHelp;
  String deliveredDate;
  String biddingEndDate;
  double estimatedBudget;
  double actualBudget;
  double finalBudget;
  String trackingLink;
  String status;
  DriverDetails driverDetails;
  List<Images> images;
  List<BiddingDetails> biddingDetails;
  String createdAt;
  int iV;

  Jobs(
      {this.fastDelivery,
      this.sendNoitification,
      this.sId,
      this.pickLocation,
      this.pickAddress,
      this.dropLocation,
      this.dropAddress,
      this.jobType,
      this.packageTitle,
      this.packageDescription,
      this.noOfItem,
      this.packageSize,
      this.packageWeight,
      this.extraHelp,
      this.deliveredDate,
      this.biddingEndDate,
      this.estimatedBudget,
      this.actualBudget,
      this.finalBudget,
      this.trackingLink,
      this.status,
      this.driverDetails,
      this.images,
      this.biddingDetails,
      this.createdAt,
      this.iV});

  Jobs.fromJson(Map<String, dynamic> json) {
    fastDelivery = json['fast_delivery'];
    sendNoitification = json['send_noitification'];
    sId = json['_id'];
    pickLocation = json['pick_location'] != null
        ? new PickLocation.fromJson(json['pick_location'])
        : null;
    pickAddress = json['pick_address'];
    dropLocation = json['drop_location'] != null
        ? new PickLocation.fromJson(json['drop_location'])
        : null;
    dropAddress = json['drop_address'];
    jobType = json['job_type'];
    packageTitle = json['package_title'];
    packageDescription = json['package_description'];
    noOfItem = json['no_of_item'];
    packageSize = json['package_size'].toDouble();
    packageWeight = json['package_weight'].toDouble();
    extraHelp = json['extra_help'];
    deliveredDate = json['delivered_date'];
    biddingEndDate = json['bidding_end_date'];
    estimatedBudget = json['estimated_budget'].toDouble();
    actualBudget = json['actual_budget'].toDouble();
    finalBudget = json['final_budget'].toDouble();
    trackingLink = json['tracking_link'];
    status = json['status'];
    driverDetails = json['driverId'] != null
        ? new DriverDetails.fromJson(json['driverId'])
        : null;
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['bidding'] != null) {
      biddingDetails = new List<BiddingDetails>();
      json['bidding'].forEach((v) {
        biddingDetails.add(new BiddingDetails.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fast_delivery'] = this.fastDelivery;
    data['send_noitification'] = this.sendNoitification;
    data['_id'] = this.sId;
    if (this.pickLocation != null) {
      data['pick_location'] = this.pickLocation.toJson();
    }
    data['pick_address'] = this.pickAddress;
    if (this.dropLocation != null) {
      data['drop_location'] = this.dropLocation.toJson();
    }
    data['drop_address'] = this.dropAddress;
    data['job_type'] = this.jobType;
    data['package_title'] = this.packageTitle;
    data['package_description'] = this.packageDescription;
    data['no_of_item'] = this.noOfItem;
    data['package_size'] = this.packageSize;
    data['package_weight'] = this.packageWeight;
    data['extra_help'] = this.extraHelp;
    data['delivered_date'] = this.deliveredDate;
    data['bidding_end_date'] = this.biddingEndDate;
    data['estimated_budget'] = this.estimatedBudget;
    data['actual_budget'] = this.actualBudget;
    data['final_budget'] = this.finalBudget;
    data['tracking_link'] = this.trackingLink;
    data['status'] = this.status;
    if (this.driverDetails != null) {
      data['driverId'] = this.driverDetails.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.biddingDetails != null) {
      data['bidding'] = this.biddingDetails.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PickLocation {
  String type;
  List<double> coordinates;

  PickLocation({this.type, this.coordinates});

  PickLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class DriverDetails {
  double noOfRatings;
  double totalRating;
  String sId;
  String name;
  String email;
  String phone;
  String password;
  String pin;
  String image;
  List<Addresses> addresses;

  DriverDetails(
      {this.noOfRatings,
      this.totalRating,
      this.sId,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.pin,
      this.image,
      this.addresses});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    noOfRatings = json['no_of_ratings'].toDouble();
    totalRating = json['total_rating'].toDouble();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_of_ratings'] = this.noOfRatings;
    data['total_rating'] = this.totalRating;
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

class Images {
  String sId;
  String path;

  Images({this.sId, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['path'] = this.path;
    return data;
  }
}

class BiddingDetails {
  String sId;
  String driverId;
  double bid;
  String remarks;
  String createdAt;

  BiddingDetails(
      {this.sId, this.driverId, this.bid, this.remarks, this.createdAt});

  BiddingDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driverId = json['driverId'];
    bid = json['bid'].toDouble();
    remarks = json['remarks'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driverId'] = this.driverId;
    data['bid'] = this.bid;
    data['remarks'] = this.remarks;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
