import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/controller.dart';



class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int perPageItem = 0;
  late int pageCount;
  int selectedIndex = 0;
  late int lastPageItemLength;
  late PageController pageController;
  Future? category;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    category = Controller.categoryy(context);

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
            child: FutureBuilder<dynamic>(
                future: category,
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.none){
                    return const Center(child: Text('لا يتوافر اتصال بالانترنت'));
                  }else
                  if (snapshot.hasData) {
                    return PageView.builder(
                        controller: pageController,
                        itemCount: snapshot.data.length,
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
                                (2 - 1) != pageIndex
                                    ? snapshot.data['data'].length
                                    : lastPageItemLength, (index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => Controller.navigatorGo(
                                        context,
                                        //
                                        SizedBox()),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/folder.png'))),
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(9),
                                      alignment: Alignment.topCenter,
                                      child: null,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data'][index]['name']!
                                        .toString(),
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
                  }else {
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
  }
}
