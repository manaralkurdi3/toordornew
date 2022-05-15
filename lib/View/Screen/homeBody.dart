import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/calender.dart';

import '../../Model/fetch_all_businesses.dart';
import 'business_details.dart';
import 'calenderevent.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

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
  late PageController pageController;
  bool indicator = false;
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Future<List<DataFetchAllBusinessesModel>>? cashing;

  @override
  void initState() {
    cashing = controller.fetchAllBusinesses(context);
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
                child: FutureBuilder<List<DataFetchAllBusinessesModel>>(
                  future: cashing,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    if (snapshot.hasData == false) {
                      return const Center(child: Text('لا توجد بينات'));
                    } else {
                      int perPageItem = 9;

                      late int lastPageItemLength;

                      pageController = PageController(initialPage: 0);
                      var num = (snapshot.data!.length / perPageItem);
                      pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

                      var reminder =
                          snapshot.data!.length.remainder(perPageItem);
                      lastPageItemLength =
                          reminder == 0 ? perPageItem : reminder;

                      return Column(
                        children: [
                          Expanded(
                            flex: 22,
                            child: PageView.builder(
                                controller: pageController,
                                itemCount: pageCount,
                                onPageChanged: (index) =>
                                    setState(() => selectedIndex = index),
                                itemBuilder: (_, pageIndex) {
                                  return GridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    primary: false,
                                    childAspectRatio: 1.1,
                                    shrinkWrap: true,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    crossAxisCount: 3,
                                    children: List.generate(
                                        (pageCount - 1) != pageIndex
                                            ? perPageItem
                                            : lastPageItemLength, (index) {
                                      return GestureDetector(
                                        onTap: () => Controller.navigatorGo(
                                            context, Calendar()),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              margin: const EdgeInsets.all(12),
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color((math.Random()
                                                                  .nextDouble() *
                                                              0xFFFFFF)
                                                          .toInt())
                                                      .withOpacity(1),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data?[index]
                                                                  .logoPNG ??
                                                              ''))),
                                              child: Text(snapshot.data?[index].bFullName ?? '')),
                                        ),
                                      );
                                    }),
                                  );
                                }),
                          ),
                          Expanded(
                              flex: 1,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: pageCount,
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          pageController.animateToPage(index,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut);
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color: Colors.red.withOpacity(
                                                  selectedIndex == index
                                                      ? 1
                                                      : 0.5)),
                                          margin: const EdgeInsets.all(5),
                                          width: 10,
                                          height: 10,
                                        ));
                                  }))
                        ],
                      );
                    }
                  },
                ),
              ),
            )),
        Flexible(
          flex: 7,
          child: Container(
            child: Text(
              'ads',
              style: TextStyle(fontSize: 90),
            ),
          ),
        )
      ]),
    ));
  }
}
