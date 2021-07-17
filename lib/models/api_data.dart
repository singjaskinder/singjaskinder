class ApiData {
  ApiData({this.data, this.statusCode, this.statusMessage, this.url});

  Map<String, dynamic> data;
  int statusCode;
  String statusMessage;
  String url;
}
