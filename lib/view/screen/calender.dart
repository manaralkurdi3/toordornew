import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/const/new_url_links.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/widget/TextForm.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/calender_event.dart';

import '../../controller/controller.dart';
import '../../model/appointment_user.dart';

class Calender extends StatefulWidget {
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();

  // late Map<DateTime, List> _events;
  //late List _selectedEvents;
  late AnimationController _animationController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  int indexPage = 0;
  Controller controller = Controller();
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Map<DateTime, List<Event>>? selectedEvents;
  DateTime selectedDay = DateTime.now();

  // CalendarController _calendarController;
  void onDaySelected(DateTime day, List events, List holidays) {
    if (selectedEvents == null) {
      print('CALLBACK: _onDaySelected');
      setState(() {
        selectedEvents = Event as Map<DateTime, List<Event>>;
      });
    } else {
      const Center(child: CircularProgressIndicator());
    }
  }

  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        isLoading = false;
        //     showStatus(result, true);
      });
    } else {
      setState(() {
        //  showStatus(result, false);
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();

    //selectedEvents = _events[_selectedDay] ?? [];
    //  _calendarController = CalendarController();
    selectedEvents = {};
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
   return Scaffold(
      appBar:AppBar2(context:context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 220,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () =>
                      Controller.navigatorOff(context, HomeBodyCategory()),
                     // Controller.navigatorGo(context, HomeBodyCategory()),
                  child: Text(
                    "حجز موعد".tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<AppointmentUser>>(
                future: Controller.userAppointment(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData&&snapshot.data!=[]) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            if(snapshot.data!=null){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 250,
                                  width: 40,
                                  decoration: BoxDecoration(border: Border.all(),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("من:".tr()),
                                          ),
                                          Text('${snapshot.data?[index].fromDate ?? ""}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("الى:".tr()),
                                          ),
                                          Text('${snapshot.data?[index].toDate ?? ""}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("اسم الخدمة:".tr()),
                                          ),
                                          Text('${snapshot.data?[index].service?.serviceName??""}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("اسم العمل:".tr()),
                                          ),
                                          Text('${snapshot.data?[index].bussnise?.BussniseName??""}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("ملاحظات:".tr()),
                                          ),
                                          Text('${snapshot.data?[index].comments ??""}'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("التاريخ:".tr()),
                                          ),
                                          Text('${snapshot.data?[index].dateDay ?? ""}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {
                                              setState((){
                                                showAlertDialog(context,snapshot.data?[index].id);
                                              });
                                            },
                                            child:  Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(

                                                  ),
                                                    color: Colors.grey
                                                ),
                                                child: Center(child: Text("الغاء الموعد".tr()))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            else{
                              return Container(child: Text("لايوجد اي مواعيد".tr()),);
                            }

                          }),
                    );
                  } else {
                    return  Center(
                      child: Text("لايوجد اي مواعيد".tr()),
                    );
                  }
                }),
            // TableCalendar(
            //   focusedDay: selectedDay,
            //   firstDay: DateTime(1990),
            //   lastDay: DateTime(2050),
            //   // calendarFormat: format,
            //   onFormatChanged: (CalendarFormat _format) {
            //     setState(() {
            //       print("===");
            //       print(selectedDay);
            //       print(selectedDay.month);
            //     });
            //   },
            //   startingDayOfWeek: StartingDayOfWeek.sunday,
            //   daysOfWeekVisible: true,
            //
            //   //Day Changed
            //   onDaySelected: (DateTime selectDay, DateTime focusDay) async {
            //     print(selectDay);
            //   },
            //   selectedDayPredicate: (DateTime date) {
            //     return isSameDay(selectedDay, date);
            //   },
            //
            //   eventLoader: _getEventsfromDay,
            //
            //   //To style the Calendar
            //   calendarStyle: CalendarStyle(
            //     isTodayHighlighted: true,
            //     selectedDecoration: BoxDecoration(
            //       color: Colors.blue,
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     selectedTextStyle: TextStyle(color: Colors.white),
            //     todayDecoration: BoxDecoration(
            //       color: Colors.purpleAccent,
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     defaultDecoration: BoxDecoration(
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     weekendDecoration: BoxDecoration(
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //   ),
            //   headerStyle: HeaderStyle(
            //     formatButtonVisible: true,
            //     titleCentered: true,
            //     formatButtonShowsNext: false,
            //     formatButtonDecoration: BoxDecoration(
            //       color: Colors.blue,
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //     formatButtonTextStyle: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // ..._getEventsfromDay(selectedDay).map(
            //   (Event event) => ListTile(
            //     title: Text(
            //       event.title,
            //     ),
            //   ),
            // ),

            // //   TableCalendar(
            //     firstDay: DateTime.utc(2010, 10, 16),
            //     lastDay: DateTime.utc(2030, 3, 14),
            //     focusedDay: DateTime.now(),
            //     onPageChanged: (focusedDay) {
            //       state(()=>
            //       _focusedDay = focusedDay
            //       );}
            // // ));
            // Expanded(
            //   flex: 4,
            //   child: SfCalendar(),
            // ),
          ],
        ),
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
showAlertDialog(BuildContext context,request_id) {

  // set up the buttons
  Widget remindButton = TextButton(
    child: Text("تاكيد".tr()),
    onPressed:  () async {
      String token =
          await SharedPreferences.getInstance()
          .then((value) =>
      value.getString('token') ?? '');
      Map<String, String> header = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      Response response=   await post(Uri.parse(ApiLinks.userAppoinmentCancel),
          body: json.encode(
              {'id': request_id}),
          headers: header).whenComplete(() => print(""));
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Calender()));
      Controller.userAppointment(context);

    },
  );
  Widget cancelButton = TextButton(
    child: Text("الغاء"),
    onPressed:  () {
        Navigator.pop(context);

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("هل انت متأكد من الغاء الطلب".tr()),
    actions: [
      remindButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}