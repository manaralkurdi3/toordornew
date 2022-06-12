import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:toordor/Controller/controller.dart';



import 'calender_event.dart';

class Category extends StatefulWidget {
  int id;

  Category({Key? key,required this.id}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}


class _CategoryState extends State<Category> {
  Controller controller = Controller();
  late int pageCount;
  int selectedIndex = 0;
  late PageController pageController;


  Future<dynamic>? category;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);

    category = Controller.Bussnisefetchall(context, widget.id);
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
              Flexible(
                  flex: 16,
                  child: Container(
                      color: Colors.grey.shade50,
                      child: RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: FutureBuilder<dynamic>(
                              future: category,
                              builder: (context, snapshot) {
                                List data=snapshot.data['data'];
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CupertinoActivityIndicator());
                                }
                                if (snapshot.hasData == false) {
                                  return const Center(
                                      child: Text('لا توجد بينات'));
                                } else {
                                  return Column(children: [
                                    Expanded(
                                      flex: 22,
                                      child:
                                          //  Map<dynamic,dynamic> data =snapshot.data!;
                                          GridView.builder(
                                        itemCount:
                                           data.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.landscape
                                              ? 3
                                              : 2,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: (2 / 1),
                                        ),
                                        itemBuilder: (
                                          context,
                                          index,
                                        ) {
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
                                             data.length;

                                          return GestureDetector(
                                            onTap: () {
                                              Controller.navigatorGo(
                                                  context, Calendar());
                                              //     Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                                            },
                                            child: Container(
                                              color: Colors.amberAccent,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  // Icon(items[index].icon),
                                                  Text(
                                                      data
                                                              [index]
                                                              ['business_name']
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                      textAlign:
                                                          TextAlign.center),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Expanded(
                                    //     flex: 1,
                                    //     child: ListView.builder(
                                    //         shrinkWrap: true,
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemCount:
                                    //             data.length,
                                    //         itemBuilder: (_, index) {
                                    //           return GestureDetector(
                                    //               onTap: () {},
                                    //               child: AnimatedContainer(
                                    //                 duration: const Duration(
                                    //                     milliseconds: 100),
                                    //                 decoration: BoxDecoration(
                                    //                     borderRadius:
                                    //                         const BorderRadius
                                    //                                 .all(
                                    //                             Radius.circular(
                                    //                                 10)),
                                    //                     color: Colors.red
                                    //                         .withOpacity(
                                    //                             selectedIndex ==
                                    //                                     index
                                    //                                 ? 1
                                    //                                 : 0.5)),
                                    //                 margin:
                                    //                     const EdgeInsets.all(5),
                                    //                 width: 10,
                                    //                 height: 10,
                                    //               ));
                                    //         })),
                                    const Flexible(
                                      flex: 7,
                                      child: Text(
                                        'ads',
                                        style: TextStyle(fontSize: 90),
                                      ),
                                    )
                                  ]);
                                }
                              }))))
            ])));
  }
}
