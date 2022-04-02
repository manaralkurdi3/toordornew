import 'package:flutter/material.dart';


import '../../Controller/Controller.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Controller c=Controller();

  int indexPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
                'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
          // IconButton(
          //     onPressed: () => showModalBottomSheet(
          //         context: context,
          //         builder: (context) => Column(
          //               children: c.listPage
          //                   .map((e) => ListTile(
          //                         title: Text(e.title),
          //                         trailing: Icon(e.icon),
          //                         onTap: () {},
          //                       ))
          //                   .toList(),
          //             )),
          //     icon: const Icon(Icons.more_vert))
        ],
        // title: TextForm(hint: 'البحث', controller: search,widget: IconButton(
        //   icon: const Icon(Icons.search),
        //   onPressed: (){},
        // ),keyBoardType: TextInputType.text,),
      ),
      endDrawer: Drawer(
        child: Column(
          children:c. listPage
              .map((e) => ListTile(
                    title: Text(e.title),
                    trailing: Icon(e.icon),
                    onTap: () {},
                  ))
              .toList(),
        ),
      ),
      body:c. listPage[indexPage].page,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.shifting, // Shifting
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        //fixedColor: Colors.red,
        onTap: (i)=>setState(() =>indexPage=i),
        currentIndex: indexPage,

        items:c. listPage
            .map((e) =>
                BottomNavigationBarItem(label: e.title, icon: Icon(e.icon),backgroundColor:  Colors.black))
            .toList(),
      ),

    );
  }
}
