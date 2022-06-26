import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toordor/controller/controller.dart';

import '../../model/employee_services.dart';
import '../../model/services.dart';

class CalendarEvent extends StatefulWidget {
  int bussniseId;

  CalendarEvent(this.bussniseId);

  @override
  _CalendarEventState createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();
  bool bool1 = false;
  bool bool2 = false;
  bool bool3 = false;
String serviceName="";
  String  services = "" ;
  String  servicesEmployee = "" ;
  int idServices=0;
  bool showServiceEmployee=false;
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ESTech Calendar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
        FutureBuilder<List<ServicesIndexOfbussnise>>(
          future: Controller.servicesIndex(context, widget.bussniseId.toString()),
          builder: (context,snapshot) {
           if(snapshot.hasData){
             return Container(
                 decoration: BoxDecoration(
                     borderRadius:  BorderRadius.circular(3),
                     color: Colors.grey[300]),
                 child: DropdownButtonHideUnderline
                   (
                 child: DropdownButton(hint:  Text(services.isEmpty? "اختر الخدمة ":services),

                 items: snapshot.data!.map((value) {
               return  DropdownMenuItem(
                 onTap: ()=>idServices=value.id??1,
                 value: value.serviceName,
                 child:  Text(
                   value.serviceName??'',
                 ),
               );
             }).toList(),
               onChanged: (val){
                   setState(() {
                     services=val.toString();
                    showServiceEmployee=true;

                   });

               })));
           }else{
             print(snapshot.error);
             return const Center(child: CircularProgressIndicator());
           }
          }
        ),
          Visibility(
            visible: showServiceEmployee,
            child: FutureBuilder<List<ServicesEmployee>>(
                future: Controller.servicesEmployee(context,idServices.toString()??'0'),
                builder: (context,snapshot) {
                  if(snapshot.hasData){
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(3),
                            color: Colors.grey[300]),
                        child: DropdownButtonHideUnderline
                          (
                            child: DropdownButton(hint:  Text(servicesEmployee.isEmpty? "اختر الموظف ":servicesEmployee),
                                items: snapshot.data!.map((value) {
                                  return  DropdownMenuItem(
                                    value: value.name??"",
                                    child:  Text(
                                      value.name??'',
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val){
                                  setState(() {
                                    servicesEmployee=val.toString();
                                    print(val);
                                  });

                                })));
                  }else{
                    print(snapshot.data);
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
          Expanded(
            child: TableCalendar(
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
                print(selectDay.month);
                setState(() {
                  showDialog(
                      context: context,
                      builder: (context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    RadioListTile(
                                        value: bool1,
                                        groupValue: bool1,
                                        title: Text('موظف 1'),
                                        onChanged: (bool? value) =>
                                        bool1 = value!),
                                    RadioListTile(
                                        value: bool1,
                                        groupValue: bool1,
                                        title: Text('موظف 1'),
                                        onChanged: (bool? value) =>
                                        bool1 = value!),
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

              eventLoader: _getEventsfromDay,

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
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class Event {
  final String title;

  Event({required this.title});

  String toString() => this.title;
}
