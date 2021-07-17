class BiddingM {
  String message;
  List<Biddings> biddings;

  BiddingM({this.message, this.biddings});

  BiddingM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      biddings = new List<Biddings>();
      json['data'].forEach((v) {
        biddings.add(new Biddings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.biddings != null) {
      data['data'] = this.biddings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Biddings {
  String sId;
  DriverId driverId;
  int bid;
  String remarks;
  String createdAt;

  Biddings({this.sId, this.driverId, this.bid, this.remarks, this.createdAt});

  Biddings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driverId = json['driverId'] != null
        ? new DriverId.fromJson(json['driverId'])
        : null;
    bid = json['bid'];
    remarks = json['remarks'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.driverId != null) {
      data['driverId'] = this.driverId.toJson();
    }
    data['bid'] = this.bid;
    data['remarks'] = this.remarks;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class DriverId {
  int noOfRatings;
  int totalRating;
  String sId;
  String name;
  String email;
  String phone;
  String image;

  DriverId(
      {this.noOfRatings,
      this.totalRating,
      this.sId,
      this.name,
      this.email,
      this.phone,
      this.image});

  DriverId.fromJson(Map<String, dynamic> json) {
    noOfRatings = json['no_of_ratings'];
    totalRating = json['total_rating'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_of_ratings'] = this.noOfRatings;
    data['total_rating'] = this.totalRating;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}
