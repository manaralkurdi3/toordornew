import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:toordor/View/Widget/TextForm.dart';

import '../../controller/controller.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
 static int indexPage = 0;
//String? token;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();


@override
  void initState() {
    super.initState();
    Controller.setPage=setPage;
  }
 void setPage(int index){
    setState(()=> Home.indexPage=index);
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Container(
            child: const SizedBox(width: 300),
            height: 100,
            width: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                    'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
              ),
            ),
          ),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => Controller.listPage
                    .map((e) => PopupMenuItem(
                        child: ListTile(
                            trailing: Text(e.title)),
                        onTap: () => setState(
                            () =>Home. indexPage = Controller.listPage.indexOf(e))))
                    .toList())
          ],
          title: TextForm(
              hint: 'البحث',
              onchange: (String? value) =>
                  Controller.query(context, query: value),
              widget: IconButton(
                icon: const Icon(Icons.search, color: Colors.blue),
                onPressed: () {},
              ),
              keyBoardType: TextInputType.text)),
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('اضغط مره اخري للحروج')),
          child: Controller.listPage[Home.indexPage].page),
    );
  }
}
