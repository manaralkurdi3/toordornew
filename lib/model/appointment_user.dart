class AppointmentUser {
  int? id;
  int? userId;
  int? employeeId;
  dynamic  busineesId;
  dynamic comments;
  String? status;
  String? fromDate;
  String? toDate;
  String? dateDay;
  String? createdAt;
  String? updatedAt;

  AppointmentUser(
      {this.id,
        this.userId,
        this.employeeId,
        this.busineesId,
        this.comments,
        this.status,
        this.fromDate,
        this.toDate,
        this.dateDay,
        this.createdAt,
        this.updatedAt});

  AppointmentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    busineesId = json['businees_id'];
    comments = json['comments'];
    status = json['status'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    dateDay = json['date_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}