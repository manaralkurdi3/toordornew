import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  PageController pageController = PageController();
  List<String> list = [];
  int perPageItem = 9;
  late int pageCount;
  int selectedIndex = 0;
  late int lastPageItemLength;
  PageController pageControlle = PageController();

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    for (int i = 1; i <= 45; i++) {
      list.add('$i');
    }
    var num = (list.length / perPageItem);

    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = list.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(
          flex: 1,
          child: Text(
            "username",
            style: TextStyle(fontSize: 17),
          ),
        ),
        ElevatedButton(
          onPressed: () => Controller.navigatorGo(context, Calender()),
          child: const Text("Mycalender", style: TextStyle()),
        ),
        Expanded(
          flex: 5,
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
                      //itemSeclected
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(5),
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: Text(
                          list[index + (pageIndex * perPageItem)],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),
                    );
                  }),
                );
              }),
        ),
        SizedBox(
          height: 22,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: pageCount,
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
                    ));
              }),
        ),
      ],
    ));
  }
}


