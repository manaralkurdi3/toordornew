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

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
      children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.start ,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                   child: Text("مرحبا منار",style: TextStyle(fontSize: 15.sp),),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Controller.navigatorGo(context, Calender()),
                  child: Text("مواعيدي",style: TextStyle(fontSize: 12.sp),),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: PageView.builder(
                  itemCount: 3,
                  allowImplicitScrolling: false,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        shrinkWrap: true,
                        itemCount: Controller.category.length,
                        itemBuilder: (context, index) {
                          return Image.asset(Controller.category[index]);
                        });
                    //   Column(
                    //   children: [
                    //     Row(
                    //       children: [HomeCard()],
                    //     ),
                    //     Row(children: [],) ,
                    //     Row(children: [],),
                    //   ],
                    // );
                  })),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            ),
          )
      ],
    ),
        ));
  }
}
