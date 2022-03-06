class Users {
  int? uID;
  String? fullName;
  String? uName;
  String? uPass;
  String? resetCode;
  String? phone1;
  String? emailAdrs;
  String? adrsCity;
  String? usrCountry;
  String? gMaps;
  String? lastLoginDate;
  String? webSiteAuth;
  String? uPNG;
  bool? isSysAdmin;
  bool? isActive1;

  Users(
      {this.uID,
        this.fullName,
        this.uName,
        this.uPass,
        this.resetCode,
        this.phone1,
        this.emailAdrs,
        this.adrsCity,
        this.usrCountry,
        this.gMaps,
        this.lastLoginDate,
        this.webSiteAuth,
        this.uPNG,
        this.isSysAdmin,
        this.isActive1});

  Users.fromJson(Map<String, dynamic> json) {
    uID = json['UID'];
    fullName = json['FullName'];
    uName = json['UName'];
    uPass = json['UPass'];
    resetCode = json['ResetCode'];
    phone1 = json['Phone1'];
    emailAdrs = json['EmailAdrs'];
    adrsCity = json['AdrsCity'];
    usrCountry = json['UsrCountry'];
    gMaps = json['gMaps'];
    lastLoginDate = json['LastLoginDate'];
    webSiteAuth = json['WebSiteAuth'];
    uPNG = json['UPNG'];
    isSysAdmin = json['IsSysAdmin'];
    isActive1 = json['IsActive1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UID'] = this.uID;
    data['FullName'] = this.fullName;
    data['UName'] = this.uName;
    data['UPass'] = this.uPass;
    data['ResetCode'] = this.resetCode;
    data['Phone1'] = this.phone1;
    data['EmailAdrs'] = this.emailAdrs;
    data['AdrsCity'] = this.adrsCity;
    data['UsrCountry'] = this.usrCountry;
    data['gMaps'] = this.gMaps;
    data['LastLoginDate'] = this.lastLoginDate;
    data['WebSiteAuth'] = this.webSiteAuth;
    data['UPNG'] = this.uPNG;
    data['IsSysAdmin'] = this.isSysAdmin;
    data['IsActive1'] = this.isActive1;
    return data;
  }
}