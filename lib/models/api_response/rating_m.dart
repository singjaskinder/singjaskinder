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
  DriverM driver;
  String userId;
  double rating;
  String review;
  String createdAt;
  String updatedAt;
  int iV;

  Ratings(
      {this.sId,
      this.jobId,
      this.driver,
      this.userId,
      this.rating,
      this.review,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Ratings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobId = json['job_id'];
    driver = json['driver_id'] != null
        ? new DriverM.fromJson(json['driver_id'])
        : null;
    userId = json['user_id'];
    rating = json['rating'].toDouble();
    review = json['review'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['job_id'] = this.jobId;
    if (this.driver != null) {
      data['driver_id'] = this.driver.toJson();
    }
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class DriverM {
  String sId;
  String name;
  String image;

  DriverM({this.sId, this.name, this.image});

  DriverM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
