import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/model/category_model.dart';
import 'package:toordor/view/screen/bussnise_of_category_screen.dart';
import 'package:toordor/view/screen/calender.dart';


class HomeBody extends StatefulWidget {
   HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();

}



class _HomeBodyState extends State<HomeBody> {
  Controller controller = Controller();
  late int pageCount;
  int selectedIndex = 0;
   PageController pageController =  PageController();
  bool indicator = false;
  int indexPage = 0;
  int perPageItem = 9;
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Future? cashing;
  late int lastPageItemLength;


 Future<List<CategoryModel>> category(BuildContext context)=>Controller.categoryy(context);


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
            const  Padding(
                padding:  EdgeInsets.only(right: 8, top: 12),
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
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<CategoryModel>>(
                      future: category(context),
                      builder: (context, snapshot) {

                        var num = (snapshot.data?.length??0 / perPageItem);
                        pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

                        late int? reminder = snapshot.data!.length.remainder(perPageItem);
                        lastPageItemLength = reminder == 0 ? perPageItem : reminder;

                        if (snapshot.connectionState == ConnectionState.none) {
                          return const Center(
                              child: Text('لا يتوافر اتصال بالانترنت'));
                        } else if (snapshot.hasData) {
                          return PageView.builder(
                              controller: pageController,
                              itemCount: pageCount,
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
                                      (pageCount - 1) != pageIndex
                                          ? perPageItem
                                          : lastPageItemLength, (index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => HomeBody1(
                                                      '${snapshot.data?[index + (pageIndex * perPageItem)].id}'
                                                          ))),
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
                                       const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${snapshot.data?[index + (pageIndex * perPageItem)].name}',
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
                    itemCount: 4,
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
          ),
     const  Expanded(
           flex: 1,
           child: SizedBox())
        ],
      ),
    );


  }
}
