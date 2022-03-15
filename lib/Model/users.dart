import 'package:xml/xml.dart';

class Users {
  int? uID;
  String? fullName;
  String? uName;
  String? uPass;

  String? phone1;

  Users({
    this.uID,
    this.fullName,
    this.uName,
    this.uPass,
    this.phone1,
  });

  Users.fromXml(XmlDocument xml) {
    uID = int.parse(xml.findAllElements('UID').toString());
    fullName = xml.findAllElements('FullName').toString();
    uName = xml.findAllElements('UName').toString();
    uPass = xml.findAllElements('UPass').toString();

    phone1 = xml.findAllElements('Phone1').toString();
  }
  Users.fromJson(json) {
    uID = json['UID'];
    fullName = json['FullName'];
    uName = json['UName'];
    uPass = json['UPass'];

    phone1 = json['Phone1'];
  }
}
//ظظTo parse this JSON data, do

//  final welcome6 = welcome6FromJson(jsonString);

// import 'dart:convert';
//
// Welcome6 welcome6FromJson(String str) => Welcome6.fromJson(json.decode(str));
//
// String welcome6ToJson(Welcome6 data) => json.encode(data.toJson());
//
// class Welcome6 {
//   Welcome6({
//     this.arrayOfUser,
//   });
//
//   ArrayOfUser? arrayOfUser;
//
//   factory Welcome6.fromJson(Map<String, dynamic> json) => Welcome6(
//         arrayOfUser: ArrayOfUser.fromJson(json["ArrayOfUser"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "ArrayOfUser": arrayOfUser!.toJson(),
//       };
// }
//
// class ArrayOfUser {
//   ArrayOfUser({
//     this.user,
//   });
//
//   List<User>? user;
//
//   factory ArrayOfUser.fromJson(Map<String, dynamic> json) => ArrayOfUser(
//         user: List<User>.from(json["User"].map((x) => User.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "User": List<dynamic>.from(user!.map((x) => x.toJson())),
//       };
// }
//
// class User {
//   User({
//     this.adrsCity,
//     this.emailAdrs,
//     this.fullName,
//     this.isActive1,
//     this.isSysAdmin,
//     this.lastLoginDate,
//     this.phone1,
//     this.resetCode,
//     this.uid,
//     this.uName,
//     this.upng,
//     this.uPass,
//     this.usrCountry,
//     this.webSiteAuth,
//     this.gMaps,
//   });
//
//   String? adrsCity;
//   String? emailAdrs;
//   String? fullName;
//   String? isActive1;
//   String? isSysAdmin;
//   String? lastLoginDate;
//   int? phone1;
//   String? resetCode;
//   int? uid;
//   String? uName;
//   String? upng;
//   int? uPass;
//   String? usrCountry;
//   String? webSiteAuth;
//   String? gMaps;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         adrsCity: json["AdrsCity"],
//         emailAdrs: json["EmailAdrs"],
//         fullName: json["FullName"],
//         isActive1: json["IsActive1"],
//         isSysAdmin: json["IsSysAdmin"],
//         lastLoginDate: json["LastLoginDate"],
//         phone1: json["Phone1"],
//         resetCode: json["ResetCode"],
//         uid: json["UID"],
//         uName: json["UName"],
//         upng: json["UPNG"],
//         uPass: json["UPass"],
//         usrCountry: json["UsrCountry"],
//         webSiteAuth: json["WebSiteAuth"],
//         gMaps: json["gMaps"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "AdrsCity": adrsCity,
//         "EmailAdrs": emailAdrs,
//         "FullName": fullName,
//         "IsActive1": isActive1,
//         "IsSysAdmin": isSysAdmin,
//         "LastLoginDate": lastLoginDate,
//         "Phone1": phone1,
//         "ResetCode": resetCode,
//         "UID": uid,
//         "UName": uName,
//         "UPNG": upng,
//         "UPass": uPass,
//         "UsrCountry": usrCountry,
//         "WebSiteAuth": webSiteAuth,
//         "gMaps": gMaps,
//       };
// }
