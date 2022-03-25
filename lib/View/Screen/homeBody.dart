import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/calender.dart';
import 'package:toordor/View/Widget/home_card.dart';

class HomeBody extends StatefulWidget{
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {


  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: Column(
    children: [
      Expanded(
        flex: 1,
        child: Container(
          child: Text("username"),
        ),
      ),
      InkWell(
         onTap: ()=> Controller.navigatorGo(context, Calender()),
        child: Container(
          child: Text("Mycalender"),
        ),
      ),
      Expanded(
        flex: 3,
        child: PageView.builder(
          itemCount: 14,
          allowImplicitScrolling: false,
          scrollDirection: Axis.horizontal,
            itemBuilder:(context,index) {
            return  GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
                itemCount: 9,
                itemBuilder: (context,index){
              return HomeCard(index: index);
                }
            );
            //   Column(
            //   children: [
            //     Row(
            //       children: [HomeCard()],
            //     ),
            //     Row(children: [],) ,
            //     Row(children: [],),
            //   ],
            // );
            }
        
        )
),

      // Expanded(
      //   flex: 1,
      //  child: Container(
      //    color: Colors.green,
      //  ),
      // )
    ],
  ));
  
}

  }