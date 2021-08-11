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
  int packageSize;
  int packageWeight;
  int extraHelp;
  String deliveredDate;
  String biddingEndDate;
  double estimatedBudget;
  double actualBudget;
  double finalBudget;
  String trackingLink;
  String status;
  String driverId;
  List<Images> images;
  List<Bidding> bidding;
  UserId userId;
  String createdAt;
  String updatedAt;
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
      this.driverId,
      this.images,
      this.bidding,
      this.userId,
      this.createdAt,
      this.updatedAt,
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
    packageSize = json['package_size'];
    packageWeight = json['package_weight'];
    extraHelp = json['extra_help'];
    deliveredDate = json['delivered_date'];
    biddingEndDate = json['bidding_end_date'];
    estimatedBudget = json['estimated_budget'].toDouble();
    actualBudget = json['actual_budget'].toDouble();
    finalBudget = json['final_budget'].toDouble();
    trackingLink = json['tracking_link'];
    status = json['status'];
    driverId = json['driverId'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['bidding'] != null) {
      bidding = new List<Bidding>();
      json['bidding'].forEach((v) {
        bidding.add(new Bidding.fromJson(v));
      });
    }
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['estimated_budget'] = this.estimatedBudget.toDouble();
    data['actual_budget'] = this.actualBudget.toDouble();
    data['final_budget'] = this.finalBudget.toDouble();
    data['tracking_link'] = this.trackingLink;
    data['status'] = this.status;
    data['driverId'] = this.driverId;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.bidding != null) {
      data['bidding'] = this.bidding.map((v) => v.toJson()).toList();
    }
    if (this.userId != null) {
      data['userId'] = this.userId.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

class Bidding {
  String sId;
  String driverId;
  double bid;
  int count;
  String remarks;
  String createdAt;

  Bidding(
      {this.sId,
      this.driverId,
      this.bid,
      this.count,
      this.remarks,
      this.createdAt});

  Bidding.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driverId = json['driverId'];
    bid = json['bid'].toDouble();
    count = json['count'];
    remarks = json['remarks'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driverId'] = this.driverId;
    data['bid'] = this.bid.toDouble();
    data['remarks'] = this.remarks;
    data['count'] = this.count;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class UserId {
  String profileImage;
  String sId;
  String phone;
  String name;

  UserId({this.profileImage, this.sId, this.phone, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    sId = json['_id'];
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}
