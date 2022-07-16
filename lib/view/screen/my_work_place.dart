import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toordor/Controller/controller.dart';
import 'package:toordor/View/Widget/TextForm.dart';

import '../block/cubit/myWorkPlace_cubit.dart';

class MyWorkPlace extends StatefulWidget {
  const MyWorkPlace({this.userId = '', Key? key}) : super(key: key);

  final String userId;

  @override
  State<MyWorkPlace> createState() => _MyWorkPlaceState();
}

class _MyWorkPlaceState extends State<MyWorkPlace> {
  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
    print("userId${widget.userId}");

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   leading: Container(
      //     child: const SizedBox(width: 300),
      //     height: 100,
      //     width: 150,
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         fit: BoxFit.fitWidth,
      //         image: AssetImage(
      //             'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     PopupMenuButton(
      //         itemBuilder: (context) => Controller.listPage
      //             .map(
      //               (e) => PopupMenuItem(
      //                 child: ListTile(trailing: Text(e.title)),
      //                 onTap: () => setState(
      //                   () => indexPage = Controller.listPage.indexOf(e),
      //                 ),
      //               ),
      //             )
      //             .toList())
      //   ],
      //   title: TextForm(
      //       hint: 'البحث',
      //       onchange: (String? value) =>
      //           Controller.query(context, query: value),
      //       widget: IconButton(
      //         icon: const Icon(Icons.search, color: Colors.blue),
      //         onPressed: () {},
      //       ),
      //       keyBoardType: TextInputType.text),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 30,
              width: 105,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue[300],
              ),
              child: Text(
                'الطلبات  ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 120,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //employee name
                          // Text(
                          //   'yousef',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      MyWorkPlaceCubit.get(context)
                                          .acceptRequest(
                                              requestId: widget.userId);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 105,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue[300],
                                      ),
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      MyWorkPlaceCubit.get(context)
                                          .cancelRequest(
                                              requestId: widget.userId);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 105,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue[300],
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              //Business name
                              Text(
                                'Business name',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
