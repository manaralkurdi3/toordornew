

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Controller/controller.dart';

class Calender extends StatefulWidget{
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender>with TickerProviderStateMixin {
 DateTime _focusedDay = DateTime.now();
 late Map<DateTime, List> _events;
 late List _selectedEvents;
 late AnimationController _animationController;
 CalendarFormat _calendarFormat = CalendarFormat.month;
 DateTime? _selectedDay;
 // CalendarController _calendarController;
 void onDaySelected(DateTime day, List events, List holidays) {
   print('CALLBACK: _onDaySelected');
   setState(() {
     _selectedEvents = events;
   });
 }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(const Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(const Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(const Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(const Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(const Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(const Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(const Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(const Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(const Duration(days: 3)):
      Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(const Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(const Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(const Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(const Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(const Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
  //  _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration:  const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
   double h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           const SizedBox(height: 25),
            Expanded(
                flex:5,
                child:
                SfCalendar(
                  view: CalendarView.month,
                  timeSlotViewSettings:const TimeSlotViewSettings(
                      startHour: 9,
                      endHour: 16,
                      nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
                  showCurrentTimeIndicator: true,
                  monthViewSettings: MonthViewSettings(showAgenda: true,
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    showTrailingAndLeadingDates: true,

                  ),
                )),
        Expanded(
          flex: 1,
          child: Padding(
            padding:  EdgeInsets.all(8.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor)
                  ),
                  onPressed: () =>Controller().selectTime(context),
                  child: Text("اختر وقت الخدمة "),
                ),
                Text("${Controller().selectedTime.hour}:${Controller().selectedTime.minute}"),

              ],
            ),
          ),
        ),
                //   TableCalendar(
                //     firstDay: DateTime.utc(2010, 10, 16),
                //     lastDay: DateTime.utc(2030, 3, 14),
                //     focusedDay: DateTime.now(),
                //     onPageChanged: (focusedDay) {
                //       state(()=>
                //       _focusedDay = focusedDay
                //       );}
                // ));
            Expanded(flex: 4,
            child: SfCalendar(),
            ),

          ],
        ),
      ),
    );
  }

}
