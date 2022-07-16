import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/controller.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/view/screen/bussnise_of_category_screen.dart';
import 'package:toordor/view/screen/calender.dart';
import 'package:toordor/view/screen/category_list.dart';

class HomeBody extends StatefulWidget {
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

class _HomeBodyState extends State<HomeBody> {
  Controller controller = Controller();
  late int pageCount;
  int selectedIndex = 0;
  late PageController pageController = new PageController();
  bool indicator = false;
  int indexPage = 0;

  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Future? cashing;
  late int lastPageItemLength;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(pageCount!=null){
    //   setState(() =>indicator==true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.only(top: 20, right: 10),
                          child: Text(
                            "مرحبا ${snapshot.data!.getString('fullname')}",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
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
                padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () =>
                          Controller.navigatorGo(context, Calender()),
                      child: Text(
                        "مواعيدي",
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 12),
                child: Text(
                  'اختيار العنصر',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
                future: Controller.categoryy(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                        child: Text('لا يتوافر اتصال بالانترنت'));
                  } else if (snapshot.hasData) {
                    return PageView.builder(
                        controller: pageController,
                        itemCount: categorylist.length,
                        //snapshot.data.length,
                        onPageChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        itemBuilder: (_, pageIndex) {
                          return GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            primary: false,
                            childAspectRatio: 1.1,
                            shrinkWrap: true,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            children: List.generate(
                                // (2 - 1) != pageIndex
                                //     ? snapshot.data['data'].length
                                //     : lastPageItemLength,
                                (2 - 1) != pageIndex
                                    ? categorylist.length
                                    : categorylist.length, (index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeBody1(
                                                snapshot.data['data'][index]
                                                        ['id']
                                                    .toString()))),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    //   margin: const EdgeInsets.all(5),
                                    //   padding: const EdgeInsets.all(9),
                                    //   alignment: Alignment.topCenter,
                                    //   child: null,
                                    // ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categorylist[index].text,
                                    // snapshot.data['data'][index]['name']!
                                    //     .toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }),
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          SizedBox(
            height: 15.sp,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.red
                            .withOpacity(selectedIndex == index ? 1 : 0.5)),
                    margin: const EdgeInsets.all(5),
                    width: 10,
                    height: 10,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );

    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Expanded(
    //           flex: 4,
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   FutureBuilder<SharedPreferences>(
    //                     future: SharedPreferences.getInstance(),
    //                     builder: (context, snapshot) {
    //                       if (snapshot.hasData) {
    //                         return Container(
    //                           padding: const EdgeInsets.only(top: 20),
    //                           child: Text(
    //                             "مرحبا ${snapshot.data!.getString('fullname')}",
    //                             style: TextStyle(fontSize: 15.sp),
    //                           ),
    //                         );
    //                       } else {
    //                         return const CupertinoActivityIndicator();
    //                       }
    //                     },
    //                   )
    //                 ],
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(bottom: 8.0),
    //                 child: Row(
    //                   children: [
    //                     ElevatedButton(
    //                       onPressed: () =>
    //                           Controller.navigatorGo(context, Calendar()),
    //                       child: Text(
    //                         "مواعيدي",
    //                         style: TextStyle(fontSize: 12.sp),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           )),
    //       Expanded(
    //           flex: 16,
    //           child: Container(
    //             color: Colors.grey.shade50,
    //             child: RefreshIndicator(
    //               onRefresh: () async => setState(() =>cashing),
    //               child: FutureBuilder(
    //                 future: cashing,
    //                 builder: (context, snapshot) {
    //                   if (snapshot.connectionState == ConnectionState.waiting) {
    //                     return const Center(
    //                         child: CupertinoActivityIndicator());
    //                   }
    //                   if (snapshot.hasData == false) {
    //                     return const Center(child: Text('لا توجد بينات'));
    //                   } else {
    //                     int perPageItem = 9;
    //
    //                     late int lastPageItemLength;
    //
    //                     pageController = PageController(initialPage: 0);
    //                     var num = (snapshot.data!.length / perPageItem);
    //                     pageCount = num.isInt ? num.toInt() : num.toInt() + 1;
    //
    //                     var reminder =
    //                         snapshot.data!.length.remainder(perPageItem);
    //                     lastPageItemLength =
    //                         reminder == 0 ? perPageItem : reminder;
    //
    //                     return Column(
    //                       children: [
    //                         Expanded(
    //                           flex: 22,
    //                           child: PageView.builder(
    //                             controller: pageController,
    //                             itemCount: pageCount,
    //                             onPageChanged: (index) =>
    //                                 setState(() => selectedIndex = index),
    //                             itemBuilder: (_, pageIndex) {
    //                               return GridView.count(
    //                                 physics:
    //                                     const NeverScrollableScrollPhysics(),
    //                                 padding: const EdgeInsets.fromLTRB(
    //                                     16, 16, 16, 0),
    //                                 primary: false,
    //                                 childAspectRatio: 1.1,
    //                                 shrinkWrap: true,
    //                                 crossAxisSpacing: 0,
    //                                 mainAxisSpacing: 0,
    //                                 crossAxisCount: 3,
    //                                 children: List.generate(
    //                                     (pageCount - 1) != pageIndex
    //                                         ? perPageItem
    //                                         : lastPageItemLength, (index) {
    //                                   return GestureDetector(
    //                                     onTap: () => Controller.navigatorGo(
    //                                         context, Calendar()),
    //                                     child: ClipRRect(
    //                                       borderRadius:
    //                                           BorderRadius.circular(12),
    //                                       child: Container(
    //                                           width: 50,
    //                                           height: 50,
    //                                           margin: const EdgeInsets.all(12),
    //                                           alignment: Alignment.bottomCenter,
    //                                           decoration: BoxDecoration(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(8),
    //                                               color: Color((math.Random()
    //                                                               .nextDouble() *
    //                                                           0xFFFFFF)
    //                                                       .toInt())
    //                                                   .withOpacity(1),
    //                                               image: DecorationImage(
    //                                                   image: NetworkImage(
    //                                                       snapshot.data?[index]
    //                                                               .logoPNG ??
    //                                                           ''))),
    //                                           child: Text(snapshot.data?[index].bFullName ?? '')),
    //                                     ),
    //                                   );
    //                                 }),
    //                               );
    //                             },
    //                           ),
    //                         ),
    //                         Expanded(
    //                           flex: 1,
    //                           child: ListView.builder(
    //                             shrinkWrap: true,
    //                             scrollDirection: Axis.horizontal,
    //                             itemCount: pageCount,
    //                             itemBuilder: (_, index) {
    //                               return GestureDetector(
    //                                   onTap: () {
    //                                     pageController.animateToPage(index,
    //                                         duration: const Duration(
    //                                             milliseconds: 500),
    //                                         curve: Curves.easeInOut);
    //                                   },
    //                                   child: AnimatedContainer(
    //                                     duration:
    //                                         const Duration(milliseconds: 100),
    //                                     decoration: BoxDecoration(
    //                                         borderRadius:
    //                                             const BorderRadius.all(
    //                                                 Radius.circular(10)),
    //                                         color: Colors.red.withOpacity(
    //                                             selectedIndex == index
    //                                                 ? 1
    //                                                 : 0.5)),
    //                                     margin: const EdgeInsets.all(5),
    //                                     width: 10,
    //                                     height: 10,
    //                                   ));
    //                             },
    //                           ),
    //                         )
    //                       ],
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //           )),
    //       const Expanded(
    //         flex: 7,
    //         child: Text(
    //           'ads',
    //           style: TextStyle(fontSize: 90),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
