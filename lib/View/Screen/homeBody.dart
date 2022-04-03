import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/calender.dart';
import 'package:toordor/View/Widget/home_card.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

class _HomeBodyState extends State<HomeBody> {
  int perPageItem = 9;

  late int pageCount;
  int selectedIndex = 0;
  late int lastPageItemLength;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    for (var i in Controller.category) {}
    var num = (Controller.category.length / perPageItem);
    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = Controller.category.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;
    // TODO: implement initState
    print(Controller.category.length);
    super.initState();
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
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "مرحبا منار",
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => Controller.navigatorGo(context, Calender()),
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
          child: PageView.builder(
              controller: pageController,
              itemCount: pageCount,
              onPageChanged: (index) => setState(() => selectedIndex = index),
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
                      (pageCount - 1) != pageIndex
                          ? perPageItem
                          : lastPageItemLength, (index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(12),
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Image.asset(
                          Controller
                              .category[index + (pageIndex * perPageItem)],
                        ),
                      ),
                    );
                  }),
                );
              }),
          //   Column(
          //   children: [
          //     Row(
          //       children: [HomeCard()],
          //     ),
          //     Row(children: [],) ,
          //     Row(children: [],),
          //   ],
          // );
        ),
        Flexible(
            flex: 1,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pageCount,
                itemBuilder: (_, index) {
                  return GestureDetector(
                      onTap: () {
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
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
                      ));
                })),
        Flexible(
          flex: 7,
          child: Container(color: Colors.blue,),
        )
      ]),
    ));
  }
}
