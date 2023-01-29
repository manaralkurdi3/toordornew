


import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toordor/view/screen/add_project.dart';
import 'package:toordor/view/screen/home.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/logout_screen.dart';
import 'package:toordor/view/screen/my_work_place.dart';
import 'package:toordor/view/screen/setting.dart';
import 'package:toordor/view/screen/time_workplace.dart';
import 'package:toordor/view/screen/user_profile.dart';
import 'package:toordor/view/widget/constant.dart';

import '../../const/color.dart';

class SettingNew extends StatefulWidget {
  const SettingNew({Key? key}) : super(key: key);

  @override
  State<SettingNew> createState() => _SettingNewState();
}

class _SettingNewState extends State<SettingNew> {
  static List<Pages> list = [
    Pages(title: 'الرئيسية', page: HomeBodyCategory()),
    Pages(title: 'حسابي', page: UserProFile()),
    // Pages(title: 'اعمالي', page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', page: AddProject()),
    Pages(title: 'اوقات العمل', page: TimeWorkPlace()),
    // Pages(title: 'عروض التوظيف', page: MyEmployees()),
    Pages(title: 'طلبات التوظيف', page: MyWorkPlace()),
    Pages(title: 'اعدادات ', page: SettingPage()),
    //Pages(title: 'تسجيل الخروج', page: Logout()),
  ];
  @override
  Widget build(BuildContext context) {
    return Mainpage(
      childfloat: Container(),
      child : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: list.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Container(
                          child: Text(list[index].title,style:TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                          ),)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Container(
                            child: Icon(Icons.arrow_back_ios,color: ColorCustome.colorblue,size: 20),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              );
            }),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Logout()));

                  },
                  child: Container(
                    height:50,width: 179,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorCustome.colorblue,
                        ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("تسجيل الخروج",style: TextStyle(fontSize:16),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                            height: 30,
                            child: Image.asset("assets/exit.png",height: 30,width:20,color: ColorCustome.colorblue,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),


              ],
            ),
          )
        ],
      )
    );
  }
}
