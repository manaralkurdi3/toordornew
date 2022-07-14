import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/Screen/home_page_bussnise.dart';
import 'package:toordor/view/Widget/TextForm.dart';

class MyBusiness extends StatefulWidget {
  MyBusiness({Key? key}) : super(key: key);

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  TextEditingController business = TextEditingController();
  TextEditingController timer = TextEditingController();

  String? tryMentType, lengthTryType;
  Future? userService;

  @override
  void initState() {
    userService = Controller.getServiceEmployee(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Controller.getServiceEmployee(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: Controller.myBuisness(context, id: 1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //   List data = snapshot.data!['data'];

            // return ListView.builder(
            //   itemCount: data.length,
            //   itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.0.sp),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              'A',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            radius: 30.sp,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'wppoo',
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'ID: ${snapshot.data['bID']}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    height: MySize.height(context) / 2.5,
                    child: Wrap(
                      children: [
                        Container(
                          // margin: EdgeInsets.all(10),
                          height: h,
                          width: w,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.sp),
                                TextForm(
                                    hint: "نوع  الخدمة ", controller: business),
                                TextForm(
                                  hint: 'وقت الخدمه المتوقغ "دقائق"',
                                  controller: timer,
                                ),

                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            Controller.createNewService(context,
                                                treatmentType: business.text,
                                                trtLenght: timer.text,
                                                bID: snapshot.data['bID']
                                                    .toString());
                                            // Controller.getServiceEmployee(
                                            //     context);
                                            // Controller.navigatorGo(context,
                                            //     const Homepagebussnise());
                                          });
                                        },
                                        child: const Text('حفظ'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('تعديل'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('الغاء'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.blue)),
                                      ),
                                    ],
                                  ),
                                ),

                                // Expanded(
                                //   child: FutureBuilder<dynamic>(
                                //       future: userservice,
                                //       builder: (context, snapshot) {
                                //         if (snapshot.hasData) {
                                //           return ListView.builder(
                                //             itemBuilder: (context, index) {
                                //               var map = snapshot.data?['data'][index];
                                //               print(map);
                                //               trymenttype = map['treatmentType'];
                                //               lengthtrytype = map['trtLenght'].toString();
                                //               return Wrap(
                                //                 children: [
                                //                   Padding(
                                //                     padding: const EdgeInsets.symmetric(
                                //                         horizontal: 10.0, vertical: 20),
                                //                     child: Column(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment.start,
                                //                       children: [
                                //                         Row(
                                //                           mainAxisAlignment:
                                //                               MainAxisAlignment.start,
                                //                           children: [
                                //                             Padding(
                                //                               padding: EdgeInsets.only(
                                //                                   left: 13.0.sp),
                                //                               child: Text(trymenttype ?? ''),
                                //                             ),
                                //                             Text(
                                //                               lengthtrytype ?? '',
                                //                               style: const TextStyle(
                                //                                   fontSize: 15,
                                //                                   color: Colors.black,
                                //                                   fontWeight:
                                //                                       FontWeight.w700),
                                //                             )
                                //                           ],
                                //                         ),
                                //                         // SizedBox(height: MySize.height(context) / 20),
                                //                         // SizedBox(height: MySize.height(context) / 20),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ],
                                //               );
                                //             },
                                //           );
                                //         } else {
                                //           return const Center(
                                //               child: CircularProgressIndicator());
                                //         }
                                //       }),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Row(
                  //     children: [
                  //       TextButton(
                  //         onPressed: () {},
                  //         child: Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.blue, shape: BoxShape.circle),
                  //             height: 40,
                  //             width: 40,
                  //             child: const Icon(
                  //               Icons.add,
                  //               color: Colors.black,
                  //             )),
                  //       ),
                  //       Text(
                  //         'اضافة خدمه جديدة',
                  //         style: TextStyle(fontSize: 15.sp),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 11),
                ],
              ),
            );
            //   },
            // );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
