import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toordor/controller/size.dart';

import '../../const/color.dart';

class Homepagebussnise extends StatefulWidget {
  const Homepagebussnise({Key? key}) : super(key: key);

  @override
  _HomepagebussniseState createState() => _HomepagebussniseState();
}

class _HomepagebussniseState extends State<Homepagebussnise> {
  DateTime toDay = DateTime.now();

  @override
  Widget build(BuildContext context) {

    Widget employ({required int index}) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          'employ $index',
          style: const TextStyle(fontSize: 19, color: Colors.white),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MySize.height(context) / 30),
            Row(
              children: const [
                FlutterLogo(size: 30),
                SizedBox(width: 20),
                Text(" اسم المشروع ",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: MySize.height(context) / 50),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: 60,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return employ(index: index + 1);
                  }),
            ),
            const SizedBox(height: 10),
            Expanded(
                flex: 14, child: SfCalendar(blackoutDates: [DateTime.now()])
                // Row(
                //   children: [
                //     Expanded(
                //         flex: 1,
                //         child: ListView.builder(
                //           itemCount: 31,
                //           itemBuilder: (context, index) {
                //             return Container(
                //               padding:const EdgeInsets.all(8),
                //               margin:const EdgeInsets.all(1),
                //               decoration: BoxDecoration(
                //                   color: Colors.blue,
                //                  // borderRadius: BorderRadius.circular(12),
                //                   border: Border.all(width: 1)),
                //               alignment: Alignment.center,
                //               child: Text('${index+1}'),
                //             );
                //           },
                //         )),
                //     Expanded(flex: 4, child: Container(color: Colors.green))
                //   ],
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
