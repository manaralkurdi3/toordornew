class LoginResponse {
  String? status;
  String? statusmsg;
  Data? data;

  LoginResponse({this.status, this.statusmsg, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusmsg = json['statusmsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusmsg'] = this.statusmsg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? expiration;
  String? username;
  String? userKey;
  String? isAdmin;

  Data(
      {this.token, this.expiration, this.username, this.userKey, this.isAdmin});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    username = json['username'];
    userKey = json['userKey'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    data['username'] = this.username;
    data['userKey'] = this.userKey;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}