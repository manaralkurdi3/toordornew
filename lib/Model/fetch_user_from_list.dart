// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.status,
    required    this.statusmsg,
    required this.data,
  });

  late String status;
  late String statusmsg;
  late List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    status: json["status"],
    statusmsg: json["statusmsg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusmsg": statusmsg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required  this.bId,
    required  this.uId,
    required  this.bFullName,
    required  this.bPhone1,
    required this.bPhone2,
    required this.bEmailAdrs,
    required this.adrsCity,
    required  this.bCountry,
    required this.gMaps,
    required  this.lastLoginDate,
    required  this.logoPng,
    required this.bBranch1,
    required  this.bBranch2,
    required   this.bBranch3,
    required  this.bBranch4,
    required  this.bBranch5,
    required   this.bBranch6,
    required  this.bBranch7,
    required this.isActive1,
    required this.currentState,
  });

  late int bId;
  late int uId;
  late String bFullName;
  late String bPhone1;
  late String bPhone2;
  late  String bEmailAdrs;
  late String adrsCity;
  late  String bCountry;
  late String gMaps;
  late int lastLoginDate;
  late dynamic logoPng;
  late  String bBranch1;
  late String bBranch2;
  late String bBranch3;
  late String bBranch4;
  late String bBranch5;
  late String bBranch6;
  late String bBranch7;
  late bool isActive1;
  late int currentState;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    bId: json["bID"],
    uId: json["uID"],
    bFullName: json["bFullName"],
    bPhone1: json["bPhone1"],
    bPhone2: json["bPhone2"],
    bEmailAdrs: json["bEmailAdrs"],
    adrsCity: json["adrsCity"],
    bCountry: json["bCountry"],
    gMaps: json["gMaps"],
    lastLoginDate: json["lastLoginDate"],
    logoPng: json["logoPNG"],
    bBranch1: json["bBranch1"],
    bBranch2: json["bBranch2"],
    bBranch3: json["bBranch3"],
    bBranch4: json["bBranch4"],
    bBranch5: json["bBranch5"],
    bBranch6: json["bBranch6"],
    bBranch7: json["bBranch7"],
    isActive1: json["isActive1"],
    currentState: json["currentState"],
  );

  Map<String, dynamic> toJson() => {
    "bID": bId,
    "uID": uId,
    "bFullName": bFullName,
    "bPhone1": bPhone1,
    "bPhone2": bPhone2,
    "bEmailAdrs": bEmailAdrs,
    "adrsCity": adrsCity,
    "bCountry": bCountry,
    "gMaps": gMaps,
    "lastLoginDate": lastLoginDate,
    "logoPNG": logoPng,
    "bBranch1": bBranch1,
    "bBranch2": bBranch2,
    "bBranch3": bBranch3,
    "bBranch4": bBranch4,
    "bBranch5": bBranch5,
    "bBranch6": bBranch6,
    "bBranch7": bBranch7,
    "isActive1": isActive1,
    "currentState": currentState,
  };
}
