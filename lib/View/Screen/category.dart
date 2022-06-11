import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Screen/calender.dart';

import '../../Model/fetch_all_businesses.dart';
import 'business_details.dart';
import 'calenderevent.dart';
import 'homeBody.dart';

class Category extends StatefulWidget {
dynamic id ;

Category(this.id);

  @override
  State<Category> createState() => _CategoryState();
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

class _CategoryState extends State<Category> {
  Controller controller = Controller();
  late int pageCount;
  int selectedIndex = 0;
  late PageController pageController;
  bool indicator = false;
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Future<List<DataFetchAllBusinessesModel>>? cashing;
  Future  ? category ;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    cashing = controller.fetchAllBusinesses(context);
    category= Controller.Bussnisefetchall(context,widget.id);
    // TODO: implement initState
    super.initState();
    // if(pageCount!=null){
    //   setState(() =>indicator==true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "مرحبا ${snapshot.data!.getString('uName')}",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        );
                      } else {
                        return const CupertinoActivityIndicator();
                      }
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => Controller.navigatorGo(context, Calendar()),
                      child: Text(
                        "مواعيدي",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 16,
                  child: Container(
                      color: Colors.grey.shade50,
                      child: RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: FutureBuilder <dynamic>(
                              future: category,
                            builder: (context,snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CupertinoActivityIndicator());
                              }
                              if (snapshot.hasData == false) {
                                return const Center(child: Text(
                                    'لا توجد بينات'));
                              } else {
                                return Column(
                                    children: [
                                      Expanded(
                                        flex: 22,
                                        child:
                                        //  Map<dynamic,dynamic> data =snapshot.data!;
                                        GridView.builder(
                                          itemCount: snapshot.data['data']!
                                              .length,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: MediaQuery
                                                .of(context)
                                                .orientation ==
                                                Orientation.landscape ? 3 : 2,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                            childAspectRatio: (2 / 1),
                                          ),
                                          itemBuilder: (context, index,) {
                                            // int perPageItem = 9;
                                            //
                                            // late int lastPageItemLength;
                                            // pageController = PageController(initialPage: 0);
                                            // var num = (snapshot.data!.length / perPageItem);
                                            // pageCount = num.isInt ? num.toInt() : num.toInt() + 1;
                                            //
                                            // var reminder =
                                            // snapshot.data!.length.remainder(perPageItem);
                                            // lastPageItemLength =
                                            // reminder == 0 ? perPageItem : reminder;
                                            pageCount =
                                                snapshot.data['data'].length;
                                            print(snapshot
                                                .data['data'][index]['business_name']
                                                .toString());
                                            return GestureDetector(
                                              onTap: () {
                                                Controller.navigatorGo(
                                                    context, Calendar());
                                                //     Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                              },
                                              child: Container(
                                                color: Colors.amberAccent,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    // Icon(items[index].icon),
                                                    Text(snapshot
                                                        .data['data'][index]['business_name']
                                                        .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .black),
                                                        textAlign: TextAlign
                                                            .center),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data['data']
                                                  .length,
                                              itemBuilder: (_, index) {
                                                return GestureDetector(
                                                    onTap: () {},
                                                    child: AnimatedContainer(
                                                      duration:
                                                      const Duration(
                                                          milliseconds: 100),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                          color: Colors.red
                                                              .withOpacity(
                                                              selectedIndex ==
                                                                  index
                                                                  ? 1
                                                                  : 0.5)),
                                                      margin: const EdgeInsets
                                                          .all(5),
                                                      width: 10,
                                                      height: 10,
                                                    ));
                                              })),
                                      Flexible(
                                        flex: 7,
                                        child: Container(
                                          child: Text(
                                            'ads',
                                            style: TextStyle(fontSize: 90),
                                          ),
                                        ),
                                      )
                                    ]);
                              }
                            }))))])));
  }
}

