import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:toordor/View/Screen/calender_event.dart';
import 'package:time_range/time_range.dart';
//import 'package:toordor/view/screen/appointement.dart';
import 'package:toordor/view/screen/calender_event.dart';

class TimeWorkPlace extends StatefulWidget {
  const TimeWorkPlace({Key? key}) : super(key: key);
  State<TimeWorkPlace> createState() => _TimeWorkPlaceState();
}

class _TimeWorkPlaceState extends State<TimeWorkPlace> {
  TimeOfDay selectedTime = TimeOfDay.now();
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;
  List weekdays=["Friday","Satarday","Sunday","Monday","Thursday","Wednesday","Thuesday"];
  List weekdays_selectuser=[];
  dynamic select=false;
  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50),
    TimeOfDay(hour: 15, minute: 20),
  );
  TimeRangeResult? _timeRange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(()  {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, left: leftPadding,right: 10),
                                child: Text(
                                  'Select Timing',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,fontSize: 15,
                                          color: dark),
                                ),
                              ),
                              SizedBox(height: 20),
                              TimeRange(
                                fromTitle: Column(
                                  children: [
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'FROM',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                toTitle: Column(
                                  children: [
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'TO',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                titlePadding: leftPadding,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: dark,
                                ),
                                activeTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                borderColor: Colors.transparent,
                                activeBorderColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                activeBackgroundColor: dark,
                                firstTime: TimeOfDay(hour: 8, minute: 00),
                                lastTime: TimeOfDay(hour: 20, minute: 00),
                                initialRange: _timeRange,
                                timeStep: 30,
                                timeBlock: 30,
                                onRangeCompleted: (range) =>
                                    setState(() => _timeRange = range),
                              ),
                              TimeRange(
                                fromTitle: Column(
                                  children: [
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'break to',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                toTitle: Column(
                                  children: [
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'Break from',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dark,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                titlePadding: leftPadding,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: dark,
                                ),
                                activeTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                borderColor: Colors.transparent,
                                activeBorderColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                activeBackgroundColor: dark,
                                firstTime: TimeOfDay(hour: 8, minute: 00),
                                lastTime: TimeOfDay(hour: 20, minute: 00),
                                initialRange: _timeRange,
                                timeStep: 30,
                                timeBlock: 30,
                                onRangeCompleted: (range) =>
                                    setState(() => _timeRange = range),
                              ),
                              Divider(),
                              Center(child: Text("weekend")),
                              Container(
                                height:100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: weekdays.length,
                                    itemBuilder:(context,index){
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap:(){
                                            select==true;
                                            print(weekdays[index]);
                                            weekdays_selectuser.contains(weekdays[index])==true?null:
                                              weekdays_selectuser.add(weekdays[index]);
                                              print(weekdays_selectuser);
                                            },
                                            child: Container(
                                              height: 30,
                                              width:90,
                                              decoration: BoxDecoration(
                                                border:Border.all(),
                                                color: select==true? Colors.blue:Colors.white,
                                              ),
                                              child: Center(child: Text(weekdays[index])),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                    } ),
                              ),
                              SizedBox(height: 30),
                              if (_timeRange != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: leftPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                                        style: TextStyle(
                                            fontSize: 20, color: dark),
                                      ),
                                      SizedBox(height: 20),
                                      MaterialButton(
                                        child: Text('Default'),
                                        onPressed: () => setState(() =>
                                            _timeRange = _defaultTimeRange),
                                        color: orange,
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        );
                      });
                });
                print("التاريخ هة ");
                selectedDay = selectDay;
                focusedDay = focusDay;
                print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              // eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(TimeRegion(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)),
        enablePointerInteraction: false,
        recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
        textStyle: TextStyle(color: Colors.black45, fontSize: 15),
        color: Colors.grey.withOpacity(0.2),
        text: 'Break'));

    return regions;
  }
}
