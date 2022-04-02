

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
         Expanded(flex: 1,child: SizedBox(),),
          StatefulBuilder(
            builder: (context,state) {
              return Expanded(
                flex: 7,
                child: SfCalendar(
                  view: CalendarView.month,
                  showCurrentTimeIndicator: true,
                  monthViewSettings: MonthViewSettings(showAgenda: true,
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    showTrailingAndLeadingDates: true
                  ),
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
        ],
      ),
    );
  }

}
