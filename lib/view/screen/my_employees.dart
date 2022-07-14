import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Controller/controller.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Screen/user_profile.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class MyEmployees extends StatelessWidget {
  MyEmployees({Key? key}) : super(key: key);
  String query = '';
  var searchController = TextEditingController();
  Future<SharedPreferences> data() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StatefulBuilder(builder: (context, update) {
              return TextForm(
                  hint: '"يرجي ادخال رقم الهاتف"البحث عن هويه',
                  controller: searchController,
                  keyBoardType: TextInputType.phone,
                  onchange: (String value) => update(() => query = value),
                  widget: IconButton(
                      icon: const Icon(Icons.search), onPressed: () {}));
            }),
            SizedBox(
                height: MySize.height(context) / 3,
                child: FutureBuilder(
                  future: Controller.query(context, query: query),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 100,
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
                                      Text(
                                        'yousef',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Container(
                                              height: 30,
                                              width: 105,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.blue[300],
                                              ),
                                              child: Text(
                                                'Send a request',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          //employee id
                                          Text(
                                            'ID 521156',
                                            style: TextStyle(
                                              fontSize: 20,
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
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
            const Divider(height: 2),
            // FutureBuilder(
            //   future: Controller.fetchTreatsTypes(context),
            //   builder: (context, snapshot) {
            //     return const SizedBox();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

Widget employCard(BuildContext context,
        {required String name, required String id}) =>
    Container(
      margin: EdgeInsets.all(9),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(77)),
      width: MySize.width(context) / 1.2,
      height: MySize.height(context) / 5,
      child: Card(
        elevation: 19,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [Text('الاسم: $name'), Text("رقم الهويه: $id")],
              ),
              ElevatedButton(onPressed: () {}, child: Text('مسح'))
            ],
          ),
        ),
      ),
    );
