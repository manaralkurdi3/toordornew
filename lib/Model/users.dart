class UserModel {
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
  dynamic logoPNG;
  String? resetCode;
  bool? isSysAdmin;
  bool? isActive1;

  UserModel(
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

  UserModel.fromJson(Map<String, dynamic> json) {
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

}