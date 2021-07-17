class VehicleM {
  String message;
  List<Vehicles> vehicles;

  VehicleM({this.message, this.vehicles});

  VehicleM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      vehicles = new List<Vehicles>();
      json['data'].forEach((v) {
        vehicles.add(new Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.vehicles != null) {
      data['data'] = this.vehicles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  String sId;
  String name;
  String description;
  double baseValue;
  String image;
  String createdAt;
  String updatedAt;
  int iV;

  Vehicles(
      {this.sId,
      this.name,
      this.description,
      this.baseValue,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Vehicles.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    baseValue = json['base_value'].toDouble();
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['base_value'] = this.baseValue;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
