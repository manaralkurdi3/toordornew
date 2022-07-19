import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/view/block/bloc_observer.dart';
import 'package:toordor/view/block/cubit/home_cubit.dart';
import 'package:toordor/view/block/cubit/myWorkPlace_cubit.dart';
import 'package:toordor/view/block/cubit/search_cubit.dart';
import 'package:toordor/view/block/cubit/sendReuest_cubit.dart';
import 'package:toordor/view/screen/home.dart';
import 'package:toordor/view/screen/login_screen.dart';

import 'View/Screen/my_employees.dart';
import 'View/Screen/splash_screen.dart';
//import 'View/block/cubit/search_cubit.dart';
import 'network/remote/api_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  ApiRequest.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print('Token ===   ${preferences.getString("token")}');
  bool data = preferences.getString('token') == null;

  runApp(MyApp(route: data));
}

class MyApp extends StatelessWidget {
  bool route;

  MyApp({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getLocation(),
        ),
        BlocProvider<MyWorkPlaceCubit>(
          create: (context) => MyWorkPlaceCubit(),
        ),
        BlocProvider(
          create: (context) => SendRequestCubit(),
        ),
        BlocProvider(create: (BuildContext context) => SearchCubit())
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'ToorDor',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: const [Locale('ar', 'EG')],
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade100,
            primarySwatch: Colors.grey,
          ),
          home: SplashScreen(route: route ? const LoginPage() : Home()),
        );
      }),
    );
  }
}
