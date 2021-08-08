class MyVehicleM {
  String message;
  List<MyVehiclesM> myVehiclesM;

  MyVehicleM({this.message, this.myVehiclesM});

  MyVehicleM.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      myVehiclesM = new List<MyVehiclesM>();
      json['data'].forEach((v) {
        myVehiclesM.add(new MyVehiclesM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.myVehiclesM != null) {
      data['data'] = this.myVehiclesM.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyVehiclesM {
  String sId;
  String name;
  String type;
  String number;
  int loadCapacity;
  String insuranceCertificate;
  String registrationCertificate;
  String inspectionCertificate;
  String vehicleImage;
  String color;
  String ownerId;
  String createdAt;
  String updatedAt;
  int iV;

  MyVehiclesM(
      {this.sId,
      this.name,
      this.type,
      this.number,
      this.loadCapacity,
      this.insuranceCertificate,
      this.registrationCertificate,
      this.inspectionCertificate,
      this.vehicleImage,
      this.color,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MyVehiclesM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    number = json['number'];
    loadCapacity = json['load_capacity'];
    insuranceCertificate = json['insurance_certificate'];
    registrationCertificate = json['registration_certificate'];
    inspectionCertificate = json['inspection_certificate'];
    vehicleImage = json['vehicle_image'];
    color = json['color'];
    ownerId = json['owner_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['number'] = this.number;
    data['load_capacity'] = this.loadCapacity;
    data['insurance_certificate'] = this.insuranceCertificate;
    data['registration_certificate'] = this.registrationCertificate;
    data['inspection_certificate'] = this.inspectionCertificate;
    data['vehicle_image'] = this.vehicleImage;
    data['color'] = this.color;
    data['owner_id'] = this.ownerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
