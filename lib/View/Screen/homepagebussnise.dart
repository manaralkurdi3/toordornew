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
    Widget employ({required int index}) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          'employ $index',
          style: const TextStyle(fontSize: 19, color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: h / 30),
            Row(
              children: const [
                FlutterLogo(size: 30),
                SizedBox(width: 20),
                Text(
                  " اسم المشروع ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: h / 50),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: 60,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return employ(index: index);
                  }),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 14,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: 31,
                        itemBuilder: (context, index) {
                          return Container(
                            padding:const EdgeInsets.all(8),
                            margin:const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                               // borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1)),
                            alignment: Alignment.center,
                            child: Text('${index+1}'),
                          );
                        },
                      )),
                  Expanded(flex: 4, child: Container(color: Colors.green))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
