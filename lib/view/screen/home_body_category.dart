import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/model/appointment_user.dart';
import 'package:toordor/model/category_model.dart';
import 'package:toordor/view/screen/bussnise_of_category_screen.dart';
import 'package:toordor/view/screen/calender.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/widget/constant.dart';

class HomeBodyCategory extends StatefulWidget {
  HomeBodyCategory({Key? key}) : super(key: key);

  @override
  State<HomeBodyCategory> createState() => _HomeBodyCategoryState();
}

class _HomeBodyCategoryState extends State<HomeBodyCategory> {
  Controller controller = Controller();
  ScrollController _scrollController = new ScrollController();
  late int pageCount;
  int selectedIndex = 0;
  PageController pageController = PageController();
  bool indicator = false;
  int indexPage = 0;
  int perPageItem = 8;
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Future? cashing;
  late int lastPageItemLength;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];
  List category_ = [
    "صالون حلاقة رجالي".tr(),
    "صالونات تجميل".tr(),
    "تصميم اظافر".tr(),
    "تعليم القيادة".tr(),
    "غسيل سيارات".tr(),
    "مدرس خاص".tr(),
    "صالات رسم الوشم".tr(),
    "مدرب شخصي".tr(),
    "علاج واستشارة طبية".tr(),
    "تصوير".tr(),
    "مدرب حيوانات".tr(),
    "مدرب سباحة".tr(),
    "تدريب الفنون".tr(),
    "كراجات وتصليح".tr(),
    "مدقق حسابات".tr(),
    "محامين".tr(),
    "ميادين الرماية".tr(),
    "عرافة".tr(),
    "علاج طبيعي/ فيزوترابيا".tr(),
    "منتجع صحي وتدليك".tr(),
    "مستشار".tr(),
    "وسيط/وكيل".tr(),
    "طبيب بيطري".tr(),
    "مطاحن".tr(),
    "مجالس محلية".tr(),
    "معاصر الزيتون".tr(),
    "طبيب اسنان".tr(),
    "قاعات الافراح والمناسبات".tr(),
    "طبيب عيون".tr(),
    "طبيب  امراض البشرة".tr(),
    "كوافير نسائي".tr()
  ];
  List<String> list = [];
  Future<dynamic> category(BuildContext context) =>
      Controller.categoryy(context);
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
            Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        isLoading = false;
        //     showStatus(result, true);
      });
    } else {
      setState(() {
        //  showStatus(result, false);
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 1);
    for (int i = 1; i <= 0; i++) {
      category_.add('$i');
    }
    var num = (category_.length / perPageItem);
    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = category_.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;
    imageCache.clear();
    imageCache.clearLiveImages();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          height: 700,
          padding: const EdgeInsets.only(top: 20, right: 10,left:12),
          child: FutureBuilder<List<CategoryModel>>(
              future: Controller.categoryy(context),
              builder: (context, snapshot) {
                return FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      return Column(
                          children: [
                        Container(
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Text(
                                "${snapshot.data!.getString('fullname')}",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "welcome".tr(),
                                  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          child: PageView.builder(
                              itemCount: 2,
                              pageSnapping: true,
                              itemBuilder: (context, pagePosition) {
                                return Container(
                                    margin: EdgeInsets.all(10),
                                    child: Image.network(images[pagePosition]));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "مواعيد اليوم",
                                style: TextStyle(
                                    color: ColorCustome.colorblue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "الكل",
                                style: TextStyle(
                                    color: ColorCustome.colorblue,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          child: FutureBuilder<List<AppointmentUser>>(
                              future: Controller.userAppointment(context),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != []) {
                                  return ListView.builder(
                                      physics: ScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        var datenow = DateTime.now();
                                        var dateTime = DateTime.parse(datenow.toString());
                                        var format1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                        print(format1);
                                        if(snapshot.data?[index].dateDay==DateTime.now())

                                          {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                  height: 50,
                                                  width: 180,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: ColorCustome.colorblue,
                                                      )),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Text("carwash"),
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text("9:30"),
                                                              Text("9:30"),
                                                            ],
                                                          ),
                                                          Text("CRWASH"),
                                                        ],
                                                      ),
                                                      // Column(
                                                      //   children: [
                                                      //     Container(
                                                      //       child: Image.asset(""),
                                                      //     )
                                                      //   ],
                                                      // )
                                                    ],
                                                  )),
                                            );
                                          }
                                        else{
                                          return Container();
                                        }

                                      });
                                } else {
                                  return Center(
                                    child: Text("لايوجد اي مواعيد".tr()),
                                  );
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text("اختيار الخدمة",style: TextStyle(
                                  fontSize: 15,
                                  color: ColorCustome.colorblue,
                                  fontWeight: FontWeight.bold

                                )),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: FutureBuilder<List<CategoryModel>>(
                                      future: Controller.categoryy(context),
                                      builder: (context, snapshot) {
                                        print(snapshot.data?.length);
                                        var num = (snapshot.data?.length ??
                                            0 / perPageItem);
                                        pageCount = num.isInt
                                            ? num.toInt()
                                            : num.toInt() + 1;
                                        late int? reminder = snapshot
                                                .data?.length
                                                .remainder(perPageItem) ??
                                            0;
                                        lastPageItemLength = reminder == 0
                                            ? perPageItem
                                            : reminder;

                                        if (snapshot.connectionState ==
                                            ConnectionState.none) {
                                          return Center(
                                              child: Text(
                                                  'لا يتوافر اتصال بالانترنت'
                                                      .tr()));
                                        } else if (snapshot.hasData) {
                                          return GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 3,
                                                mainAxisSpacing: 2,
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  snapshot.data?.length ?? 0,
                                              shrinkWrap: false,
                                              itemBuilder: (context, index) {
                                                return Column(children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        print(snapshot
                                                                .data?[index]
                                                                .id ??
                                                            0);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeBody1(snapshot
                                                                            .data?[index]
                                                                            .id ??
                                                                        0)));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 80,
                                                              width: 200,
                                                              child:
                                                                  CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl: snapshot
                                                                        .data?[
                                                                            index]
                                                                        .image ??
                                                                    "",
                                                                height: 100,
                                                                width: 200,
                                                                //  maxWidthDiskCache: 100,
                                                                // images[index].toString()
                                                              ),
                                                            ),
                                                            // //          Container(
                                                            // //            height: 40,width: 60,
                                                            // //            decoration:BoxDecoration(
                                                            // //              borderRadius: BorderRadius.circular(20),
                                                            // //              color: Colors.blue
                                                            // // ),
                                                            // //            child: Image(
                                                            // // image:AssetImage(images?[index]??""),
                                                            // //              fit: BoxFit.cover,height:40,width: 60,),
                                                            // //          ),
                                                            //       ),

                                                            // Container(
                                                            //   width: 50,
                                                            //   height: 60,
                                                            //   decoration:  BoxDecoration(
                                                            //     borderRadius: BorderRadius.circular(10),
                                                            //
                                                            //   ),
                                                            //
                                                            //   child: Padding(
                                                            //     padding: const EdgeInsets.only(top: 8.0,bottom: 10),
                                                            //     child:
                                                            //     Image.network(
                                                            //       snapshot.data?[index].image.toString()??"",
                                                            //       height: 30,
                                                            //       width: 30,
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            //   margin: const EdgeInsets.all(5),
                                                            //   padding: const EdgeInsets.all(9),
                                                            //   alignment: Alignment.topCenter,
                                                            //   child: null,
                                                            // ),

                                                            Container(
                                                              child: Text(
                                                                '${category_?[index].toString()}',
                                                                // snapshot.data['data'][index]['name']!
                                                                //     .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        11),
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ]);
                                              });
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      }),
                                ),
                              ],
                            ))
                      ]);
                    });
              })),
    ),
            bottomNavigationBar:
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: ColorCustome.colorblue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
        ),
            // Scaffold(
            //   appBar:AppBar2(context:context),
            //   body:FutureBuilder<List<CategoryModel>>(
            //     future: Controller.categoryy(context),
            //     builder: (context,snapshot) {
            //       return Padding(
            //         padding: const EdgeInsets.only(top: 20.0),
            //         child: Column(
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     FutureBuilder<SharedPreferences>(
            //                       future: SharedPreferences.getInstance(),
            //                       builder: (context, snapshot) {
            //                         if (snapshot.hasData) {
            //                           return Container(
            //                             padding: const EdgeInsets.only(top: 20, right: 10),
            //                             child: Row(
            //                               children: [
            //                                 Padding(
            //                                   padding: const EdgeInsets.only(left: 8.0),
            //                                   child: Text(
            //                                     "مرحبا".tr(),style: TextStyle(fontSize: 15),),
            //                                 ),
            //                                 Text( "${snapshot.data!.getString('fullname')}",
            //                                   style: TextStyle(
            //                                     fontSize: 15.sp,
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         } else {
            //                           return const CupertinoActivityIndicator();
            //                         }
            //                       },
            //                     )
            //                   ],
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(bottom: 8.0, right: 8),
            //                   child: Row(
            //                     children: [
            //                       ElevatedButton(
            //                         style: ElevatedButton.styleFrom(primary: Colors.blue),
            //                         onPressed: () =>
            //                             Controller.navigatorGo(context, Calender()),
            //                         child: Text(
            //                           "مواعيدي".tr(),
            //                           style: TextStyle(
            //                             fontSize: 12.sp,
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding:  EdgeInsets.only(right: 8, top: 12),
            //                   child: Text(
            //                     'اختيار الخدمة'.tr(),
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Expanded(
            //               flex: 2,
            //               child: Column(
            //                 children: [
            //                   Expanded(
            //                     child:
            //
            //                     FutureBuilder<List<CategoryModel>>(
            //                         future: Controller.categoryy(context),
            //                         builder: (context, snapshot) {
            //                           print(snapshot.data?.length);
            //                           var num = (snapshot.data?.length??0 / perPageItem);
            //                           pageCount = num.isInt ? num.toInt() : num.toInt() + 1;
            //
            //                           late int? reminder = snapshot.data?.length.remainder(perPageItem)??0;
            //                           lastPageItemLength = reminder == 0 ? perPageItem : reminder;
            //
            //                           if (snapshot.connectionState == ConnectionState.none) {
            //                             return  Center(
            //                                 child: Text('لا يتوافر اتصال بالانترنت'.tr()));
            //                           } else if (snapshot.hasData) {
            //                             return SizedBox(
            //                               height: 400,
            //                               child:
            //                               GridView.builder(
            //                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //                                     crossAxisCount: 3,
            //                                     crossAxisSpacing: 5,
            //                                     mainAxisSpacing: 3,
            //
            //                                   ),
            //                                   scrollDirection: Axis.horizontal,
            //                                   itemCount:snapshot.data?.length??0,
            //                                   shrinkWrap: false,
            //                                   itemBuilder: (context,index) {
            //                                     return Column(
            //                                         children: [
            //                                           GestureDetector(
            //                                               onTap: ()
            //                                               {
            //                                                 print(snapshot.data?[index].id??0);
            //                                                 Navigator.push(
            //                                                     context,
            //                                                     MaterialPageRoute(
            //                                                         builder: (context) =>
            //                                                             HomeBody1(
            //                                                                 snapshot.data?[index].id ?? 0
            //                                                             )));
            //                                               },
            //                                               child:
            //                                               Column(
            //                                                 children: [
            //                                                   Container(
            //                                                     width: 50,
            //                                                     height: 50,
            //                                                     decoration:  BoxDecoration(
            //                                                       borderRadius: BorderRadius.circular(10),
            //                                                       // color: Colors.blueAccent,
            //                                                     ),
            //                                                     child:CachedNetworkImage(
            //                                                       imageUrl:
            //                                                       snapshot.data?[index].image ?? "",
            //                                                       maxHeightDiskCache: 200,
            //                                                       //  maxWidthDiskCache: 100,
            //                                                       // images[index].toString()
            //                                                     ),
            //                                                   ),
            //                                                   // //          Container(
            //                                                   // //            height: 40,width: 60,
            //                                                   // //            decoration:BoxDecoration(
            //                                                   // //              borderRadius: BorderRadius.circular(20),
            //                                                   // //              color: Colors.blue
            //                                                   // // ),
            //                                                   // //            child: Image(
            //                                                   // // image:AssetImage(images?[index]??""),
            //                                                   // //              fit: BoxFit.cover,height:40,width: 60,),
            //                                                   // //          ),
            //                                                   //       ),
            //
            //
            //                                                   // Container(
            //                                                   //   width: 50,
            //                                                   //   height: 60,
            //                                                   //   decoration:  BoxDecoration(
            //                                                   //     borderRadius: BorderRadius.circular(10),
            //                                                   //
            //                                                   //   ),
            //                                                   //
            //                                                   //   child: Padding(
            //                                                   //     padding: const EdgeInsets.only(top: 8.0,bottom: 10),
            //                                                   //     child:
            //                                                   //     Image.network(
            //                                                   //       snapshot.data?[index].image.toString()??"",
            //                                                   //       height: 30,
            //                                                   //       width: 30,
            //                                                   //     ),
            //                                                   //   ),
            //                                                   // ),
            //                                                   //   margin: const EdgeInsets.all(5),
            //                                                   //   padding: const EdgeInsets.all(9),
            //                                                   //   alignment: Alignment.topCenter,
            //                                                   //   child: null,
            //                                                   // ),
            //
            //
            //                                                   Container(
            //                                                     child: Text(
            //                                                       '${category_?[index].toString()}',
            //                                                       // snapshot.data['data'][index]['name']!
            //                                                       //     .toString(),
            //                                                       style: const TextStyle(
            //                                                           color: Colors.black,
            //                                                           fontSize: 11),
            //                                                       overflow: TextOverflow.visible,
            //                                                       textAlign: TextAlign.center,
            //
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ))]);
            //                                   }),
            //
            //
            //                             );
            //                           } else {
            //                             return const Center(child: CircularProgressIndicator());
            //                           }
            //                         }),
            //                   ),
            //                   // SizedBox(
            //                   //   height: 15.sp,
            //                   //   child: ListView.builder(
            //                   //     shrinkWrap: true,
            //                   //     scrollDirection: Axis.horizontal,
            //                   //     itemCount: 4,
            //                   //     itemBuilder: (_, index) {
            //                   //       return GestureDetector(
            //                   //         onTap: () => pageController.animateToPage(index,
            //                   //             duration: const Duration(milliseconds: 500),
            //                   //             curve: Curves.easeInOut),
            //                   //         child: AnimatedContainer(
            //                   //           duration: const Duration(milliseconds: 100),
            //                   //           decoration: BoxDecoration(
            //                   //               borderRadius:
            //                   //               const BorderRadius.all(Radius.circular(10)),
            //                   //               color: Colors.red
            //                   //                   .withOpacity(selectedIndex == index ? 1 : 0.5)),
            //                   //           margin: const EdgeInsets.all(5),
            //                   //           width: 10,
            //                   //           height: 10,
            //                   //         ),
            //                   //       );
            //                   //     },
            //                   //   ),
            //                   // )
            //                 ],
            //               ),
            //             ),
            //             Expanded(
            //                 child: Padding(
            //                   padding: EdgeInsets.all(8.0),
            //                   child: SizedBox(
            //                     child: Text("اعلن هنا".tr()),
            //                   ),
            //                 ))
            //           ],
            //         ),
            //       );
            //
            //
            //
            //
            //
            //
            //     }
            //   )
            // ),
            );
  }
}
