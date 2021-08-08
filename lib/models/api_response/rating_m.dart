class RatingM {
  String message;
  List<Ratings> ratings;

  RatingM({this.message, this.ratings});

  RatingM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      ratings = new List<Ratings>();
      json['data'].forEach((v) {
        ratings.add(new Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.ratings != null) {
      data['data'] = this.ratings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  String sId;
  String jobId;
  String driverId;
  UserId userId;
  int rating;
  String review;
  String createdAt;
  String updatedAt;
  int iV;

  Ratings(
      {this.sId,
      this.jobId,
      this.driverId,
      this.userId,
      this.rating,
      this.review,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Ratings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobId = json['job_id'];
    driverId = json['driver_id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    rating = json['rating'];
    review = json['review'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['job_id'] = this.jobId;
    data['driver_id'] = this.driverId;
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
