

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatelessWidget{
 DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        const Expanded(flex: 1,child: SizedBox(),),
          StatefulBuilder(
            builder: (context,state) {
              return Expanded(
                flex: 7,
                child: SfCalendar(
                  view: CalendarView.workWeek,
                  timeSlotViewSettings: TimeSlotViewSettings(
                      startHour: 9,
                      endHour: 16,
                      nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
                ));

              //   TableCalendar(
              //     firstDay: DateTime.utc(2010, 10, 16),
              //     lastDay: DateTime.utc(2030, 3, 14),
              //     focusedDay: DateTime.now(),
              //     onPageChanged: (focusedDay) {
              //       state(()=>
              //       _focusedDay = focusedDay
              //       );}
              // ));
            }
          ),
          const Expanded(flex: 1,child: const SizedBox(),),
        ],
      ),
    );
  }

}