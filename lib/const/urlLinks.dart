String baseUrl='http://toordor.com/';

//LOGIN
String authLogin='${baseUrl}api/auth/login';//POST

// Businesses
String businesses='${baseUrl}api/TD02/businesses';
String getBusinesses='$businesses/getAll';//GET
String addBusinesses='$businesses/insert';//POST
String updateBusinesses='$businesses/update';//POST

// BusiRequists
String busiRequists='${baseUrl}api/td02/busiRequists';
String getAllBusiRequists='$busiRequists/getAll';//GET
String addBusiRequists='$busiRequists/insert';//POST
String updateBusiRequists='$busiRequists/update';//POST


// DiaryShifts
String diaryShifts='${baseUrl}api/td02/diaryShifts';
String getAllDiaryShifts='$diaryShifts/getAll';//GET
String addDiaryShifts='$diaryShifts/insert';//POST
String updateDiaryShifts='$diaryShifts/update';//POST

// Users
String users='${baseUrl}api/td02/users';
String getUsers='$users/getAll';//GET
String addUsers='$users/insert';//POST
String updateUsers='$users/update';//POST



// UsrTreatsTypes
String usrTreatsTypes='${baseUrl}td02/usrTreatsTypes';
String getUsrTreatsTypes='$usrTreatsTypes/getAll';//GET
String addUsrTreatsTypes='$usrTreatsTypes/insert';//POST
String updateUsrTreatsTypes='$usrTreatsTypes/update';//POST



//UsrWorkHours
String usrWorkHours='${baseUrl}api/td02/usrWorkHours';
String getUsrWorkHours='$usrWorkHours/getAll';
String addUsrWorkHours='$usrWorkHours/insert';
String updateUsrWorkHours='$usrWorkHours/update';