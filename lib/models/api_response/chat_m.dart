class ChatM {
  String id;
  String message;
  String date;
  bool isUser;
  int timeStamp;

  ChatM({this.id, this.message, this.date, this.isUser,this.timeStamp});

  ChatM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    date = json['date'];
    timeStamp = json['time_stamp'];
    isUser = json['is_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['date'] = this.date;
    data['is_user'] = this.isUser;
    data['time_stamp'] = this.timeStamp;
    return data;
  }
}
