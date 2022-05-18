import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/homeBody.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int perPageItem = 19;
  late int pageCount;
  int selectedIndex = 0;
  late int lastPageItemLength;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);

    var num = (Controller.category.length / perPageItem);
    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = Controller.category.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: pageController,
                itemCount: pageCount,
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
                        (pageCount - 1) != pageIndex
                            ? perPageItem
                            : lastPageItemLength, (index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Controller.navigatorGo(context, HomeBody()),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/folder.png'))),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(9),
                              alignment: Alignment.topCenter,
                              child: null,
                            ),
                          ),
                          Text(
                            Controller
                                .category[index + (pageIndex * perPageItem)],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }),
                  );
                }),
          ),
          SizedBox(
            height: 15.sp,
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
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
