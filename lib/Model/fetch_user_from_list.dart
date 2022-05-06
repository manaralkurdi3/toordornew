class FetchUserFromList {
  String? status;
  String? statusmsg;
  List<Dataa>? data;

  FetchUserFromList({this.status, this.statusmsg, this.data});

  FetchUserFromList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusmsg = json['statusmsg'];
    if (json['data'] != null) {
      data = <Dataa>[];
      json['data'].forEach((v) {
        data!.add(new Dataa.fromJson(v));
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

class Dataa {
  int? uID;
  String? fullName;
  String? uName;
  String? uPass;
  String? phone1;
  String? emailAdrs;
  String? adrsCity;
  String? usrCountry;
  String? gMaps;
  int? lastLoginDate;
  Null? logoPNG;
  String? resetCode;
  bool? isSysAdmin;
  bool? isActive1;

  Dataa(
      {this.uID,
        this.fullName,
        this.uName,
        this.uPass,
        this.phone1,
        this.emailAdrs,
        this.adrsCity,
        this.usrCountry,
        this.gMaps,
        this.lastLoginDate,
        this.logoPNG,
        this.resetCode,
        this.isSysAdmin,
        this.isActive1});

  Dataa.fromJson(Map<String, dynamic> json) {
    uID = json['uID'];
    fullName = json['fullName'];
    uName = json['uName'];
    uPass = json['uPass'];
    phone1 = json['phone1'];
    emailAdrs = json['emailAdrs'];
    adrsCity = json['adrsCity'];
    usrCountry = json['usrCountry'];
    gMaps = json['gMaps'];
    lastLoginDate = json['lastLoginDate'];
    logoPNG = json['logoPNG'];
    resetCode = json['resetCode'];
    isSysAdmin = json['isSysAdmin'];
    isActive1 = json['isActive1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uID'] = this.uID;
    data['fullName'] = this.fullName;
    data['uName'] = this.uName;
    data['uPass'] = this.uPass;
    data['phone1'] = this.phone1;
    data['emailAdrs'] = this.emailAdrs;
    data['adrsCity'] = this.adrsCity;
    data['usrCountry'] = this.usrCountry;
    data['gMaps'] = this.gMaps;
    data['lastLoginDate'] = this.lastLoginDate;
    data['logoPNG'] = this.logoPNG;
    data['resetCode'] = this.resetCode;
    data['isSysAdmin'] = this.isSysAdmin;
    data['isActive1'] = this.isActive1;
    return data;
  }
}