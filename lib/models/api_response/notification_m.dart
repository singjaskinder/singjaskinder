class NotificationM {
  String message;
  List<Notifications> notifications;

  NotificationM({this.message, this.notifications});

  NotificationM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      notifications = new List<Notifications>();
      json['data'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.notifications != null) {
      data['data'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String sId;
  String title;
  String description;
  String user;
  String createdAt;

  Notifications(
      {this.sId, this.title, this.description, this.user, this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    user = json['user'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
