import 'package:dlivrDriver/apis/api_handler.dart';
import 'package:dlivrDriver/apis/end_points.dart';
import 'package:dlivrDriver/models/api_response/rating_m.dart';
import 'package:dlivrDriver/models/api_response/review_meta_m.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/views/build_navigation/build_navigation_controller.dart';
import 'package:get/get.dart';

class MyRatingsController extends GetxController {
  BuildNavigationController buildNavigationController = Get.find();
  String imageUrl;
  String userName;
  final isEmpty = true.obs;
  ReviewMetaM reviewMetaM;
  final rating = (0.0).obs;
  final badges = [
    BadgesM(
        path: getImage('badges/experience.png'), label: 'Excellent\nservice'),
    BadgesM(path: getImage('badges/commute.png'), label: 'Great\nconversation'),
    BadgesM(path: getImage('badges/clean.png'), label: 'Neat and\ntidy'),
    BadgesM(path: getImage('badges/commute.png'), label: 'Great\nconversation'),
    BadgesM(path: getImage('badges/music.png'), label: 'Great\nmusic'),
    BadgesM(path: getImage('badges/nav.png'), label: 'Expert\nnavigation'),
    BadgesM(
        path: getImage('badges/performance.png'), label: 'Above\nand beyond'),
  ];
  final List<FoundBadgeData> acheivedBadges = [];
  final List<FoundLikeData> acheivedLikes = [];

  @override
  void onInit() {
    super.onInit();
    imageUrl = buildNavigationController.imageUrl.value ?? '';
    userName = buildNavigationController.userName.value ?? '';
  }

  Future<List<Ratings>> getRatings() async {
    List<Ratings> ratings = [];
    final res = await ApiHandler.getHttp(EndPoints.getReviews);
    final res1 = await ApiHandler.getHttp(EndPoints.reviewedDetails);
    reviewMetaM = ReviewMetaM.fromJson(res1.data);
    ratings = RatingM.fromJson(res.data).ratings;
    for (Ratings rating in ratings) {
      this.rating.value = rating.rating + this.rating.value;
    }
    this.rating.value = (this.rating.value / ratings.length);
    acheivedBadges.addAll(reviewMetaM.reviewsMeta[0].foundBadgeData);
    acheivedBadges.removeWhere((element) => element.sId == null);
    acheivedLikes.addAll(reviewMetaM.reviewsMeta[0].foundLikeData);
    acheivedLikes.removeWhere((element) => element.bId == null);
    for (BadgesM badge in badges) {
      for (FoundBadgeData badgeData in acheivedBadges) {
        if (badge.label
            .replaceAll('\n', '')
            .contains(badgeData.sId.replaceAll('\n', ''))) {
          badge.count = badgeData.count;
        } else {
          badge.count = 0;
        }
      }
    }
    return ratings;
  }

  String getThumbs(bool isLike) {
    for (FoundLikeData likeData in acheivedLikes) {
      likeData.bId = likeData.bId ?? false;
      if (likeData.bId) {
        return likeData.count.toString() + '%';
      } else {
        return likeData.count.toString() + '%';
      }
    }
  }
}

class BadgesM {
  BadgesM({this.path, this.label});
  String path;
  String label;
  int count;
}
