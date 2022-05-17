import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/theme.dart';

import 'layout/cubit/cubit.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Widget startScreen;
  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  debugPrint(token);
  if (onBoarding != null) {
    if (token != null) {
      startScreen = const ShopLayout();
    } else {
      startScreen = ShopLoginScreen();
    }
  } else {
    startScreen = const OnBoardingScreen();
  }
  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startScreen});
  final Widget? startScreen;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavorites()
        ..getUserData(),
      child: MaterialApp(
        title: 'Shop App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startScreen,
      ),
    );
  }
}
