import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:kassem_app/modules/shop_app/cateogries/categories_screen.dart';
//import 'package:kassem_app/modules/shop_app/on_boarding_app/on_boarding_screen.dart';
// import 'package:kassem_app/modules/shop_app/on_boarding_app/on_boarding_screen.dart';
import 'package:tasawq/shared/bloc_observer.dart';
import 'package:tasawq/shared/components/constants.dart';
import 'package:tasawq/shared/cubit/cubit.dart';
import 'package:tasawq/shared/cubit/states.dart';
import 'package:tasawq/shared/network/remote/cache_helper.dart';
import 'package:tasawq/shared/network/remote/dio_helper.dart';
import 'Layout/shop_layout.dart';
import 'package:firebase_core/firebase_core.dart';

import 'modules/login/shop_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = ShopLayout();
  } else {


  }

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLoginScreen();
  } else {}

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
// class myApp()
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getUserData(),
        ),

      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(

            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
