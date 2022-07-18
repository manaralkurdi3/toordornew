import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toordor/const/new_url_links.dart';
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

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents![date] ?? [];
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Container(
          child: const SizedBox(width: 300),
          height: 100,
          width: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                  'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
            ),
          ),
        ),
        actions: [
          // PopupMenuButton(
          //     itemBuilder: (context) => Controller.listPage
          //         .map((e) => PopupMenuItem(
          //             child: ListTile(trailing: Text(e.title)),
          //             onTap: () => setState(
          //                 () => indexPage = Controller.listPage.indexOf(e))))
          //         .toList())
        ],
        title: TextForm(
            hint: 'البحث',
            onchange: (String? value) =>
                Controller.query(context, query: value),
            widget: IconButton(
              icon: const Icon(Icons.search, color: Colors.blue),
              onPressed: () {},
            ),
            keyBoardType: TextInputType.text),
      ),
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
                  onPressed: () => Controller.navigatorGo(context, HomeBody()),
                  child: Text(
                    "حجز موعد",
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
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 90,
                                width: 40,decoration: BoxDecoration(border: Border.all(),color: Colors.white),
                                child: Column(
                                  children: [
                                    Text('${snapshot.data?[index].comments ?? ""}'),
                                    Text('${snapshot.data?[index].dateDay ?? ""}'),
                                    MaterialButton(
                                      onPressed: () async {
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
                                                {'id': snapshot.data?[index].id}),
                                            headers: header).whenComplete(() => setState((){}));
                                      },
                                      child: const Text("cancel"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
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
