class ServicesIndexOfbussnise {
  int? id;
  String? serviceName;
  String? image;

  ServicesIndexOfbussnise({this.id, this.serviceName, this.image});

  ServicesIndexOfbussnise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['image'] = this.image;
    return data;
  }


  Map toMapData(){
    var mapGroup = new Map<String, dynamic>();
    mapGroup["service_name"] = this.serviceName;
    mapGroup['id'] = this.id;
    mapGroup['image'] = this.image;
    return mapGroup;

  }
}