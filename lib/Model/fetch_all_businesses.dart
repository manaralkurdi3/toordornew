class FetchAllBusinessesModel {
  String? status;
  String? statusmsg;
  List<DataFetchAllBusinessesModel>? data;

  FetchAllBusinessesModel({this.status, this.statusmsg, this.data});

  FetchAllBusinessesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusmsg = json['statusmsg'];
    if (json['data'] != null) {
      data = <DataFetchAllBusinessesModel>[];
      json['data'].forEach((v) {
        data!.add(new DataFetchAllBusinessesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusmsg'] = this.statusmsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataFetchAllBusinessesModel {
  int? bID;
  int? uID;
  String? bFullName;
  String? bPhone1;
  String? bPhone2;
  String? bEmailAdrs;
  String? adrsCity;
  String? bCountry;
  String? gMaps;
  int? lastLoginDate;
  var logoPNG;
  String? bBranch1;
  String? bBranch2;
  String? bBranch3;
  String? bBranch4;
  String? bBranch5;
  String? bBranch6;
  String? bBranch7;
  bool? isActive1;
  int? currentState;

  DataFetchAllBusinessesModel(
      {this.bID,
        this.uID,
        this.bFullName,
        this.bPhone1,
        this.bPhone2,
        this.bEmailAdrs,
        this.adrsCity,
        this.bCountry,
        this.gMaps,
        this.lastLoginDate,
        this.logoPNG,
        this.bBranch1,
        this.bBranch2,
        this.bBranch3,
        this.bBranch4,
        this.bBranch5,
        this.bBranch6,
        this.bBranch7,
        this.isActive1,
        this.currentState});

  DataFetchAllBusinessesModel.fromJson(Map<String, dynamic> json) {
    bID = json['bID'];
    uID = json['uID'];
    bFullName = json['bFullName'];
    bPhone1 = json['bPhone1'];
    bPhone2 = json['bPhone2'];
    bEmailAdrs = json['bEmailAdrs'];
    adrsCity = json['adrsCity'];
    bCountry = json['bCountry'];
    gMaps = json['gMaps'];
    lastLoginDate = json['lastLoginDate'];
    logoPNG = json['logoPNG'];
    bBranch1 = json['bBranch1'];
    bBranch2 = json['bBranch2'];
    bBranch3 = json['bBranch3'];
    bBranch4 = json['bBranch4'];
    bBranch5 = json['bBranch5'];
    bBranch6 = json['bBranch6'];
    bBranch7 = json['bBranch7'];
    isActive1 = json['isActive1'];
    currentState = json['currentState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bID'] = this.bID;
    data['uID'] = this.uID;
    data['bFullName'] = this.bFullName;
    data['bPhone1'] = this.bPhone1;
    data['bPhone2'] = this.bPhone2;
    data['bEmailAdrs'] = this.bEmailAdrs;
    data['adrsCity'] = this.adrsCity;
    data['bCountry'] = this.bCountry;
    data['gMaps'] = this.gMaps;
    data['lastLoginDate'] = this.lastLoginDate;
    data['logoPNG'] = this.logoPNG;
    data['bBranch1'] = this.bBranch1;
    data['bBranch2'] = this.bBranch2;
    data['bBranch3'] = this.bBranch3;
    data['bBranch4'] = this.bBranch4;
    data['bBranch5'] = this.bBranch5;
    data['bBranch6'] = this.bBranch6;
    data['bBranch7'] = this.bBranch7;
    data['isActive1'] = this.isActive1;
    data['currentState'] = this.currentState;
    return data;
  }
}