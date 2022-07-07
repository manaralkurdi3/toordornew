import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/screen/home_body_category.dart';
import 'package:toordor/view/screen/calender_event.dart';

import '../../Controller/controller.dart';

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
          PopupMenuButton(
              itemBuilder: (context) => Controller.listPage
                  .map((e) => PopupMenuItem(
                      child: ListTile(trailing: Text(e.title)),
                      onTap: () => setState(
                          () => indexPage = Controller.listPage.indexOf(e))))
                  .toList())
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 220,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () =>
                        Controller.navigatorGo(context, HomeBody()),
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
              SfCalendar(
                headerHeight: 0,
                view: CalendarView.month,
                initialSelectedDate: DateTime.now(),
                timeSlotViewSettings: const TimeSlotViewSettings(
                    startHour: 9,
                    endHour: 16,
                    nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
                showCurrentTimeIndicator: true,
                monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                  showTrailingAndLeadingDates: true,
                ),
              ),
              ..._getEventsfromDay(selectedDay).map(
                (Event event) => ListTile(
                  title: Text(event.title),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(6.0),
              //   child: Column(
              //     children: [
              //       Container(
              //         height: 70,
              //         width: 330,
              //         decoration: BoxDecoration(
              //           color: Colors.grey[400],
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 4,
              //       ),
              //       Container(
              //         height: 70,
              //         width: 330,
              //         decoration: BoxDecoration(
              //           color: Colors.grey[400],
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 4,
              //       ),
              //       TextForm(
              //         widget: Container(
              //           height: 50,
              //         ),
              //         hint: '',
              //         visibility: true,
              //       ),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   flex: 1,
              //   child: Padding(
              //     padding: EdgeInsets.all(8.0.sp),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         ElevatedButton(
              //           style: ButtonStyle(
              //               backgroundColor: MaterialStateProperty.all(
              //                   Theme.of(context).primaryColor)),
              //           onPressed: () => Controller().selectTime(context),
              //           child: Text("اختر وقت الخدمة "),
              //         ),
              //         Text(
              //             "${Controller().selectedTime.hour}:${Controller().selectedTime.minute}"),
              //       ],
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
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
