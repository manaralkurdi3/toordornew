



import 'package:flutter/material.dart';

class Homepagebussnise extends StatefulWidget {
  const Homepagebussnise({Key? key}) : super(key: key);

  @override
  _HomepagebussniseState createState() => _HomepagebussniseState();
}

class _HomepagebussniseState extends State<Homepagebussnise> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height:h/ 10,),
            Row(
              children: [
                Text(" اسم المشروع "),
              ],
            ),
            Expanded(
              child: ListView.builder(itemCount:6,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical ,
                  itemBuilder:(BuildContext context,index)
                  {
                    return Container(decoration:BoxDecoration(
                    // borderRadius: BorderRadius.all(25),
                    ),height:30,color: Colors.blue,);
                  } ),
            )

          ],
        ),
      ),
    );
  }
}
