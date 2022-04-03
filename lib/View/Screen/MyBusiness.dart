import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/homepagebussnise.dart';
import 'package:toordor/View/Widget/TextForm.dart';

class MyBusiness extends StatelessWidget {
  MyBusiness({Key? key}) : super(key: key);
  TextEditingController business = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        height: h,
        width: w,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h/8.sp,),
               Row(
                 children: [
                   Padding(
                     padding:  EdgeInsets.only(left: 13.0.sp),
                     child: CircleAvatar(
                       backgroundColor: Colors.grey,
                       child: Text(''),
                       radius: 30.sp,
                     ),
                   ),
                   Text("اسم المشروع ",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),)
                 ],
              ),
              SizedBox(height: 10.sp),
              TextForm(hint: "وقت الخدمة ", controller: business,),
               Padding(
                 padding: const EdgeInsets.only(left:20.0),
                 child: Row(
                   children: [
      Padding(
          padding:  EdgeInsets.only(left: 20.0.sp),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.all(Colors.blue)
            ),
          onPressed: () =>Controller().selectTime(context),
          child: Text("اختر الوقت الخدمة "),
          ),
      ),
      Text("${Controller().selectedTime.hour}:${Controller().selectedTime.minute}"),
                   ],
                 ),
               ),
              Padding(
                padding:  EdgeInsets.only(bottom:12.0.sp),
                child: Row(
                  children: [
                    Text(
                      'اضافة خدمه جديده',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle),
                          height: 40,
                          width: 40,
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          )),
                    ),
                  ],


                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {
                    Controller.navigatorGo(context, Homepagebussnise());
                  }, child: const Text('حفظ'),style: ButtonStyle(
      backgroundColor:MaterialStateProperty.all(Colors.blue)
      ),),
                  ElevatedButton(onPressed: () {}, child: const Text('تعديل'),  style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.blue)
                  ),),
                  ElevatedButton(onPressed: () {}, child: const Text('الغاء'),  style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.blue)
                  ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
