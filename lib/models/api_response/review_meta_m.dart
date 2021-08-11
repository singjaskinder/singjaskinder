class ReviewMetaM {
  String message;
  List<ReviewsMeta> reviewsMeta;

  ReviewMetaM({this.message, this.reviewsMeta});

  ReviewMetaM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      reviewsMeta = new List<ReviewsMeta>();
      json['data'].forEach((v) {
        reviewsMeta.add(new ReviewsMeta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.reviewsMeta != null) {
      data['data'] = this.reviewsMeta.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewsMeta {
  List<FoundLikeData> foundLikeData;
  List<FoundBadgeData> foundBadgeData;

  ReviewsMeta({this.foundLikeData, this.foundBadgeData});

  ReviewsMeta.fromJson(Map<String, dynamic> json) {
    if (json['foundLikeData'] != null) {
      foundLikeData = new List<FoundLikeData>();
      json['foundLikeData'].forEach((v) {
        foundLikeData.add(new FoundLikeData.fromJson(v));
      });
    }
    if (json['foundBadgeData'] != null) {
      foundBadgeData = new List<FoundBadgeData>();
      json['foundBadgeData'].forEach((v) {
        foundBadgeData.add(new FoundBadgeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foundLikeData != null) {
      data['foundLikeData'] =
          this.foundLikeData.map((v) => v.toJson()).toList();
    }
    if (this.foundBadgeData != null) {
      data['foundBadgeData'] =
          this.foundBadgeData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoundLikeData {
  bool bId;
  int count;

  FoundLikeData({this.bId, this.count});

  FoundLikeData.fromJson(Map<String, dynamic> json) {
    bId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.bId;
    data['count'] = this.count;
    return data;
  }
}

class FoundBadgeData {
  String sId;
  int count;

  FoundBadgeData({this.sId, this.count});

  FoundBadgeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    return data;
  }
}
