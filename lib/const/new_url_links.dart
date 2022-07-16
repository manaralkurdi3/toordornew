class ApiLinks {
  ///base url
  static const String domain = 'https://toordor.herokuapp.com/api/';

  ///auth
  static const String register = '${domain}register'; //POST
  static const String login = '${domain}login'; //POST
  ///index
  static const String index = '${domain}index';
  static const String busineesIndex = '${domain}businees-index/'; //add id
  static const String serviceIndex = '${domain}service-index/'; //add id
  static const String serviceEmploy = '${domain}service/'; //add id
  ///busineesCreate
  static const String busineesCreate = '${domain}businees/create';
  static const String busineesGet = '${domain}businees/get';
  static const String busineesRequestSend = '${domain}businees/request/send';
  static const String busineesAppointments = '${domain}businees/appointments';
  static const String busineesServices = '${domain}businees/services';
  static const String busineesEmployees = '${domain}businees/employees';
  static const String busineesAppointmentsCancel =
      '${domain}businees/appointments/cancel';
  static const String search = '${domain}search';

  ///Employee
  static const String employeeDays = '${domain}employee/days'; //POST
  static const String employeeAppointments = '${domain}employee/appointments';
  static const String createEmployee =
      '${domain}employee/create'; //ممكن في غلط في اللينك
  static const String employeeRequestShow = '${domain}employee/request/show';
  static const String employeeRequestNumber =
      '${domain}employee/request/number';
  static const String employeeRequestAccept =
      '${domain}employee/request/accept';
  static const String employeeRequestRefuse =
      '${domain}employee/request/refuse';
  static const String employeeCreateWorkHours =
      '${domain}employee/create/workhours';

  ///App
  static const String dayDetails = '${domain}day/details';
  static const String book = '${domain}book';

  ///Users
  static const String user = '${domain}user';
  static const String editUser = '${domain}user/edit';
  static const String userAppoinment = '${domain}user/appoinment';
  static const String userAppoinmentCancel = '${domain}user/appoinment/cancel';
//some data not fond!
//Add Services
  static const String createNewServices = '${domain}service/create';
  static const String serviceIndexById = '${domain}service-index/:id';
  static const String getServicesEmployees = '${domain}service/:id';

  static const String sendRequest = '${domain}businees/request/send';
  static const String acceptRequest = '${domain}employee/request/accept';
  static const String cancelRequest = '${domain}employee/request/refuse';
}
